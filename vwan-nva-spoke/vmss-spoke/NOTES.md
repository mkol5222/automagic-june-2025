
```bash
ENVID=$(cat ../../secrets/sp.json | jq -r .envId)
RG=automagic-vwan-vmss-spoke-$ENVID
NIC=aaa
az network nic show-effective-route-table -g $RG -n $NIC --output table

az network nic --help
az network nic list --help
az network nic list -g $RG --output table
```