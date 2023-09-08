#!/bin/bash

# ts3001 check kubenetes nodes are ready
str1=$(kubectl get nodes | grep -v "Ready" | grep -q "NotReady" && echo "dptr_failed_dptr" || echo "dptr_succeed_dptr" 2>&1)

str2=${str1##*dptr_}
str3=${str2%%_dptr*}
[ $str3 == 'succeed' ]