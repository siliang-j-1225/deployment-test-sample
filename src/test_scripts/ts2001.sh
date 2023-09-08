#!/bin/bash

# ts2001 verify zookeeper connection:
zookeeper_status=$(kafka-topics.sh --zookeeper localhost:2181 --list 2>&1)

str1="failed"
if [[ $zookeeper_status != *"Connection refused"* ]]; then
    str1="succeed"
fi

[ $str1 == 'succeed' ]
