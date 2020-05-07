#!pip install lxml
import requests
import pandas as pd
import xml.etree.ElementTree as ET


class checkbook_nyc(object):
    def __init__(self, type_name, search_criteria):
        self.type_name = type_name
        self.search_criteria = search_criteria

    def build_xmlString(
        self, records_from="", max_records=""
    ):  # search criteria should be a dictionary
        type_list = ["Budget", "Revenue", "Contracts", "Payroll", "Spending"]

        if self.type_name not in type_list:
            return "please enter one of the following type: Budget, Revenue, Contracts, Payroll, Spending. [Case Sensitive]"

        s = "<request><type_of_data>{0}</type_of_data>".format(self.type_name)
        # general search criteria
        if len(records_from) > 0:
            s += "<records_from>{0}</records_from>".format(records_from)
        if len(max_records) > 0:
            s += "<max_records>{0}</max_records>".format(max_records)

        # various
        s += "<search_criteria>"
        criterias = self.search_criteria[self.type_name]
        for i, j in criterias.items():
            if len(j) != 0:
                if type(j) == str:
                    s += (
                        "<criteria>"
                        + "<name>{0}</name>".format(i)
                        + "<type>value</type>"
                        + "<value>{0}</value>".format(j)
                        + "</criteria>"
                    )
                else:
                    s += (
                        "<criteria>"
                        + "<name>{0}</name>".format(i)
                        + "<type>range</type>"
                        + "<start>{0}</start>".format(j[0])
                        + "<end>{0}</end>".format(j[1])
                        + "</criteria>"
                    )

        s += "</search_criteria></request>"
        return s

    def xml_to_df(self, root):
        data_dict = dict()
        for result_records in root:
            if result_records.tag == "result_records":
                for records in result_records:
                    if "transactions" in records.tag:
                        n = 0
                        while len(records.getchildren()) - n > 0:
                            for each in records[n]:
                                m = 0
                                while len(each.getchildren()) - m > 0:
                                    if each[m].tag not in data_dict:
                                        data_dict[each[m].tag] = []
                                    data_dict[each[m].tag].append(each[m].text)
                                    m += 1
                                if len(each.getchildren()) == 0:
                                    if each.tag not in data_dict:
                                        data_dict[each.tag] = []
                                    data_dict[each.tag].append(each.text)

                            n += 1
        return pd.DataFrame(data_dict)

    def get_raw_data(self, start):
        postString = self.build_xmlString(records_from=str(start), max_records="1000")

        have_result = False
        max_runtime = 10000
        while (not have_result) and max_runtime > 0:
            try:
                response = requests.post(
                    "https://www.checkbooknyc.com/api", data=(postString)
                )
                have_result = True
            except:
                have_result = False
                max_runtime -= 1

        if not have_result:
            print("Cannot reach the website, please check your connection.")
        return response

    def formatted_data(self):
        df = pd.DataFrame()
        response = self.get_raw_data(1)
        decode = response.content.decode("utf-8")
        root = ET.fromstring(decode)
        record_number = int(root[2][0].text)
        print("total records:{0}".format(record_number))

        nrow = 0
        while record_number - nrow > 0:
            if nrow > 0:
                response = self.get_raw_data(1 + nrow)
                decode = response.content.decode("utf-8")
                root = ET.fromstring(decode)
            df_new = self.xml_to_df(root)
            df = df.append(df_new, ignore_index=True)
            nrow = len(df.index)
            print("Now we have", nrow, "rows, almost there!")

        return df
