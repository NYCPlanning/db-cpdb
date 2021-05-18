import requests
from functools import cached_property
import xmltodict
import aiohttp
import asyncio
from random import randint
from collections import OrderedDict
import time


class CheckbookNYC(object):
    def __init__(self, type_name, search_criteria):
        self.type_name = type_name
        self.search_criteria = search_criteria
        self.endpoint = "https://www.checkbooknyc.com/api"
        self.type_list = ["Budget", "Revenue",
                          "Contracts", "Payroll", "Spending"]

        assert (
            self.type_name in self.type_list
        ), "please enter one of the following type: Budget, Revenue, Contracts, Payroll, Spending. [Case Sensitive]"

    def build_xmlString(self, records_from: int = 1, max_records: int = 1000):
        criteria = ""
        for i, j in self.search_criteria.items():
            criteria += f"<criteria><name>{i}</name><type>value</type><value>{j}</value></criteria>"

        _type_of_data = f"<type_of_data>{self.type_name}</type_of_data>"
        _records_from = (
            f"<records_from>{records_from}</records_from>" if records_from >= 1 else ""
        )
        _max_records = (
            f"<max_records>{max_records}</max_records>" if max_records >= 1 else ""
        )
        _search_criteria = f"<search_criteria>{criteria}</search_criteria>"
        _request = f"<request>{_type_of_data}{_records_from}{_max_records}{_search_criteria}</request>"
        return _request

    async def GetRawData(
        self, session, records_from: int = 1, max_records: int = 1000
    ) -> OrderedDict:
        postString = self.build_xmlString(records_from, max_records)
        tries = 1
        while tries < 5:
            try:
                async with session.post(self.endpoint, data=postString) as response:
                    print(
                        f"TRY: {tries}, FROM: {records_from} TO {records_from+1000-1}")
                    content = await response.text()
                    return xmltodict.parse(content)
            except:
                print(
                    f'FAILED, TRY:{tries}, FROM: {records_from} TO {records_from+1000-1}, retry again ...')
                tries += 1
                await asyncio.sleep(randint(5, 20))

    @cached_property
    def NumberOfRecords(self) -> int:
        postString = self.build_xmlString(1, 1)
        tries = 1
        while tries < 5:
            try:
                resp = requests.post(self.endpoint, data=postString)
                response = xmltodict.parse(resp.content)
                number_of_records = int(
                    response["response"]["result_records"]["record_count"])
                print(
                    f"total number of records for this search is: {number_of_records}")
                return number_of_records
            except:
                tries += 1
                time.sleep(randint(0, 5))

    @cached_property
    def RequestTasks(self):
        number_of_records = self.NumberOfRecords
        if number_of_records == 0:
            return []
        else:
            number_of_requests = number_of_records // 1000
            list_from = [1]
            list_from += [i * 1000 +
                          1 for i in range(1, number_of_requests + 1)]
            return list_from

    async def main(self):
        tasks = self.RequestTasks
        if len(tasks) > 0:
            async with aiohttp.ClientSession() as session:
                return await asyncio.gather(
                    *[self.GetRawData(session, task) for task in tasks]
                )
        return []

    def __call__(self):
        return asyncio.run(self.main())
