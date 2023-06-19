#!/bin/bash

# ts0007 check if hbase version is 2.4.13
str1=$(hbase version 2>/dev/null | grep '^HBase' | cut -d ' ' -f2)
echo $str1
[ $str1 == '2.4.13' ]