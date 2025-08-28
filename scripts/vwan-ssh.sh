#!/bin/bash

NVA_IPS=$(az network virtual-appliance list -o json | jq -r '.[] | .virtualApplianceNics | .[] | select(.publicIpAddress!="") | .publicIpAddress')

echo "${NVA_IPS}"
# connect to first
# ssh admin@$(echo "${NVA_IPS}" | head -n 1)
# connect to Nth

# N is first argument or default 1
N=${1:-1}
# make sure N is int and positive
N=$(($N))
if [ $N -gt 0 ]; then
  ssh admin@$(echo "${NVA_IPS}" | head -n ${N} | tail -n 1)
fi