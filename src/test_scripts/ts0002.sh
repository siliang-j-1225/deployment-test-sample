#!/bin/bash

# ts0002 check if hive version is 3.1.2
str1=$(whereis hive)
echo $str1
str2=$(echo ${str1#*hive-} | cut -d '/' -f1)
echo $str2
[ $str2 == '3.1.2' ]