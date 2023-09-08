#!/bin/bash

# ts1002 check if spark can be started and then immediately exited
str1=$(echo "println("dptr_succeed_dptr"); :q" | spark-shell --conf spark.driver.memory=512m 2>&1)

str2=${str1##*dptr_}
str3=${str2%%_dptr*}
[ $str3 == 'succeed' ]