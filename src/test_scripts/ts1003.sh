#!/bin/bash

# ts1003 check if spark can do a basic Spark computation
str1=$(echo 'val r = sc.parallelize(1 to 1000).count(); if (r != 1000) println("dptr_failed_dptr") else println("dptr_succeed_dptr")' | spark-shell --conf spark.driver.memory=512m 2>&1)

str2=${str1##*dptr_}
str3=${str2%%_dptr*}
[ $str3 == 'succeed' ]
