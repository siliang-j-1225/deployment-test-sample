#!/bin/bash

# ts2002 check if broker number is 2
broker_count=$(kafka-topics.sh --describe --bootstrap-server localhost:9092 | grep "Leader:" | wc -l) 

[ $broker_count == 2 ]
