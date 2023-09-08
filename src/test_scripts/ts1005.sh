#!/bin/bash

# ts1005 check if spark can write to local filesystem
str1=$(echo 'sc.parallelize(Seq("test")).saveAsTextFile("file:///tmp/output_test"); if (!new java.io.File("/tmp/output_test").exists()) println("dptr_failed_dptr") else println("dptr_succeed_dptr")' | spark-shell --conf spark.driver.memory=512m 2>&1)

str2=${str1##*dptr_}
str3=${str2%%_dptr*}
[ $str3 == 'succeed' ]
