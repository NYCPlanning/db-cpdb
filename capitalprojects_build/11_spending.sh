#!/bin/bash
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

start=$(date +'%T')
echo "Start at: $start"

mkdir -p downloads/spending

# if exists, drop table:
psql $BUILD_ENGINE -c 'DROP table if exists capital_spending_old;'

pip3 install xmltodict

spend2psql ()
{ # This function downloads, parses, and pushes to psql
    
    echo "Downloading XML #$1 starting with record #$2"
    wget -q -O downloads/spending/spending.xml --post-data "<request><type_of_data>Spending</type_of_data><records_from>$2</records_from><search_criteria><criteria><name>spending_category</name><type>value</type><value>cc</value></criteria></search_criteria></request>" http://www.checkbooknyc.com/api 
    
    # if there are no results, stop
    if grep -q 'no results' downloads/spending/spending.xml; then
        stop=10
        rm downloads/spending/spending.xml
        echo "No Results. Stopping"
        return 0
    fi

    # otherwise, push to psql
    echo 'Parsing XML and writing to sql...'
    python3 python/spending.py

    # if the python script broke, exit before deleting everything
    if [ "$?" -ne 0 ]; then echo "python script failed"; return 1; fi

    # remove file
    rm downloads/spending/spending.xml

} # end of spend2psql function

nextfile ()
{ # do next file, retry recursively 
    counter=0
    spend2psql $1 $2
    if [ "$?" -ne 0 ]; then
        echo "Failed for file #$i starting with record #$rec"
        echo "Retrying"
        counter=$[$counter+1]
        if [ $counter -lt 10 ]; then
            nextfile $1 $2
        else
            echo "Failed too many times"
            echo "Exiting"
            exit 1
        fi
    fi
} # end of nextfile function

stop=0
rec=1
i=1
while [ $stop -lt 1 ] #&& [ $i -lt 5 ] 
do
    # do next file
    nextfile $i $rec
    # increment
    i=$[$i+1]
    rec=$[$rec+1000]
done

# complete
end=$(date +'%T')
echo "Finished at: $end"

TABLE_NAME=capital_spending_old
pg_dump $BUILD_ENGINE | psql $EDM_DATA
psql $EDM_DATA -c "CREATE SCHEMA IF NOT EXISTS capital_spending_old;";
psql $EDM_DATA -c "ALTER TABLE capital_spending_old SET SCHEMA capital_spending_old;";
psql $EDM_DATA -c "DROP TABLE IF EXISTS capital_spending_old.\"$TABLE_NAME\";";
psql $EDM_DATA -c "ALTER TABLE capital_spending_old.capital_spending_old RENAME TO \"$TABLE_NAME\";";    