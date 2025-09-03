#!/bin/bash

make cpman-ssh

# Get all gateways
# GWS=$(mgmt_cli -r true show simple-gateways --format json | jq -r '.objects[] | .name')
# echo $GWS

# FIRSTGW=$(echo $GWS | awk '{print $1}')
# SECONDGW=$(echo $GWS | awk '{print $2}')

mgmt_cli -r true install-policy policy-package "vmss" 
#   targets.0 "$FIRSTGW" targets.1 "$SECONDGW"
