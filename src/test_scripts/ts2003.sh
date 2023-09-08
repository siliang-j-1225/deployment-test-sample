#!/bin/bash

# ts2003 check if Kafka is Accepting Connections
str1="failed"
if echo > /dev/tcp/localhost/9092; then
    str1="succeed"
fi
[ $str1 == 'succeed' ]
