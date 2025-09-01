#!/bin/bash

# public IP of VM linux77 in RG linux77-rg
IP=$(az vm show -d -g  automagic-linux77-rg -n linux77 --query publicIps -o tsv)
echo "IP:$IP|"
# not valid IP
if [ -z "$IP" ]; then
  echo "Failed to retrieve public IP for VM linux77"
  exit 1
fi

ssh azureuser@$IP