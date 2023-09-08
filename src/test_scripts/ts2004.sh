#!/bin/bash

# ts2004 Check Default Topic Configuration:
retention=$(kafka-configs.sh --zookeeper zookeeper:2181 --describe --entity-type topics --entity-default | grep "retention.ms" | awk '{print $5}')

str1="failed"
if [ "$retention" == "86400000" ]; then  # Replace desired_value_here with the value you expect
    str1="succeed"
fi

[ $str3 == 'succeed' ]
