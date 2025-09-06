#!/bin/bash

# public IP of VM linux208 in RG linux208-rg
IP=$(az vm show -d -g automagic-linux208-rg -n linux208 --query publicIps -o tsv)
echo "IP:$IP|"
# not valid IP
if [ -z "$IP" ]; then
  echo "Failed to retrieve public IP for VM linux208"
  exit 1
fi

ssh azureuser@$IP