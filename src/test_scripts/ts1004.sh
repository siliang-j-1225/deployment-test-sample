#!/bin/bash

# ts1004 check if spark can read from local filesystem
echo "test" > /tmp/test.txt
str1=$(echo 'val r = sc.textFile("file:///tmp/test.txt").count(); if (r != 1) println("dptr_failed_dptr") else println("dptr_succeed_dptr")' | spark-shell --conf spark.driver.memory=512m 2>&1)

str2=${str1##*dptr_}
str3=${str2%%_dptr*}
[ $str3 == 'succeed' ]
