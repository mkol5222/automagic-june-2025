
```bash
ENVID=$(cat ../../secrets/sp.json | jq -r .envId)
RG=automagic-vwan-vmss-spoke-$ENVID
NIC=aaa
az network nic show-effective-route-table -g $RG -n $NIC --output table

az network nic --help
az network nic list --help
az network nic list -g $RG --output table

az group list --output table | grep linux

# automagic-linux77-rg
az network nic list -g automagic-linux77-rg --output json | jq -r '.[].name'
# linux77-nic

az network nic show-effective-route-table -g automagic-linux77-rg -n linux77-nic --output table
az network nic show-effective-route-table -g automagic-linux68-rg -n linux68-nic --output table
```