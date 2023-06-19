#!/bin/bash

# ts0001 check if hadoop version is 3.3.2
str1=$(hadoop version | grep '\bHadoop\b' | cut -d ' ' -f2)
[ $str1 == '3.3.2' ]