#!/bin/bash

# ts3003 check if node number is 3
nodes=$(kubectl get nodes --no-headers | wc -l)

[ $nodes == 3 ]