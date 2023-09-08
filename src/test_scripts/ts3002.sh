#!/bin/bash

# ts3002 check k8s version
ver_str=$(kubectl version)

str1="failed"
if [[ $ver_str == *"Server Version: v1.26.6"* ]]; then
    str1="succeed"
fi

[ $str1 == 'succeed' ]