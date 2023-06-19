#!/usr/bin/env bash
if [ $MOCKING -eq 1 ]; then
    test_script="test_scripts/mock.sh"
else
    test_script="test_scripts/$1"
fi

if [ $RUN_REMOTELY -eq 1 ]; then
    # Use ssh to login to remote server to run tests
    ssh -i "<user-name>"@"<cluster-ip>" -p 22 'bash -s' < $test_script
else
    . $test_script
fi
