#!/bin/bash

# public IP of VM linux68 in RG linux68-rg
IP=$(az vm show -d -g automagic-linux68-rg -n linux68 --query publicIps -o tsv)
echo "IP:$IP|"
# not valid IP
if [ -z "$IP" ]; then
  echo "Failed to retrieve public IP for VM linux68"
  exit 1
fi

ssh azureuser@$IP