#!/bin/bash

# ts0004 check if hbase version is 2.4.5
str1=$(echo stat|nc localhost 2181 | grep 'version')
echo $str1
str2=$(echo ${str1#*version:} | cut -d '-' -f1)
echo $str2
[ $str2 == '3.5.7' ]