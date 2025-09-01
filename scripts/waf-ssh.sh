#!/bin/bash

# public IP of VM linux77 in RG linux77-rg
IP=$(az vm show -d -g rg-waf-vwan -n vm-waf-vwan --query publicIps -o tsv)
echo "IP:$IP|"
# not valid IP
if [ -z "$IP" ]; then
  echo "Failed to retrieve public IP for VM vm-waf-vwan"
  exit 1
fi

ssh admin@$IP