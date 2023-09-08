#!/bin/bash

# ts1006 check if spark can use all available CPU cores
str1=$(echo 'val cores = Runtime.getRuntime.availableProcessors; val r = sc.parallelize(1 to cores*1000, cores).map(_ => Thread.currentThread.getId).distinct.count; if (r != cores) println("dptr_failed_dptr") else println("dptr_succeed_dptr")' | spark-shell --conf spark.driver.memory=512m 2>&1)

str2=${str1##*dptr_}
str3=${str2%%_dptr*}
[ $str3 == 'succeed' ]
