#!/bin/bash

# ts0003 check if spark version is 3.1.2
str1=$(spark-shell --version 2>&1 | grep '  version')
echo $str1
str2=${str1#*version}
echo $str2
[ $str2 == '3.1.2' ]