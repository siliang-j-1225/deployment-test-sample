#!/bin/bash

# ts1001 check if spark version is 3.4.1
str1=$(spark-shell --version 2>&1 | grep '  version')

str2=${str1#*version}
[ $str2 == '3.4.1' ]