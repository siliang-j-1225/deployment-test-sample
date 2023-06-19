#!/usr/bin/env bash

setup_suite() {
    echo                        >&3
    echo "====================" >&3
    echo "BEGIN: setup_suite"   >&3
    # this will be run before all tests inside this folder
    # put costly steps here. i.e., creating resources
    load '../utilities/common_setup'
    _common_setup

    . create_test_env.sh >&3

    echo "END: setup_suite"     >&3
    echo "====================" >&3
    echo                        >&3
}

teardown_suite() {
    echo                        >&3
    echo "====================" >&3
    echo "BEGIN: teardown_suite"   >&3

    # this will be run after all tests inside this folder
    # kill resources, clean up
    . remove_test_env.sh >&3

    echo "END: teardown_suite"     >&3
    echo "====================" >&3
    echo                        >&3
}