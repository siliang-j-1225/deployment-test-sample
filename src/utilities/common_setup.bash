#!/usr/bin/env bash

_common_setup() {

    PROJECT_ROOT="$( cd "$( dirname "$BATS_TEST_FILENAME" )/.." >/dev/null 2>&1 && pwd )"
    # make executables in utilities/ visible to PATH
    PATH="$PROJECT_ROOT/utilities:$PATH"

    # Load environment variables, which will be used to setup testing environments
    if [[ -z "$DEPLOYMENT_TEST_ENV" ]]; then
        DEPLOYMENT_TEST_ENV='dev'
    fi

    echo >&3                     
    echo "Loading ENV VARs, DEPLOYMENT_TEST_ENV=$DEPLOYMENT_TEST_ENV"  >&3
    source "./${DEPLOYMENT_TEST_ENV}.env.sh"

    # Load input data, which will be used as test data
    if [[ -z "$DEPLOYMENT_TEST_DATA" ]]; then
        DEPLOYMENT_TEST_DATA='set1'
    fi

    echo >&3  
    echo "Loading INPUT DATA, DEPLOYMENT_TEST_DATA=$DEPLOYMENT_TEST_DATA" >&3
    source "./test_datas/${DEPLOYMENT_TEST_DATA}.sh"
}
