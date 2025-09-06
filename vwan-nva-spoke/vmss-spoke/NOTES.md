
```bash
ENVID=$(cat ../../secrets/sp.json | jq -r .envId)
RG=automagic-vwan-vmss-spoke-$ENVID
az network nic list -g $RG --output table
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

az network nic show-effective-route-table -g automagic-linux77-rg -n linux77-nic --output table | grep '0.0.0.0/0'

az network nic show-effective-route-table -g automagic-linux208-rg -n linux208-nic --output table

#VMSS eth0 NIC
# /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/automagic-vwan-vmss-spoke-aa41adff/providers/Microsoft.Compute/virtualMachineScaleSets/vmss-spoke-aa41adff/virtualMachines/0/networkInterfaces/eth0
# /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/automagic-vwan-vmss-spoke-aa41adff/providers/Microsoft.Compute/virtualMachineScaleSets/vmss-spoke-aa41adff/virtualMachines/1/networkInterfaces/eth1
az network nic show-effective-route-table \
  --resource-group automagic-vwan-vmss-spoke-aa41adff \
  --name eth0 \
  --vm vmss-spoke-aa41adff_0

# --vm unrecognized

az vmss nic list \
  --resource-group automagic-vwan-vmss-spoke-aa41adff \
  --vmss-name vmss-spoke-aa41adff \
  --instance-id 0 \
  -o table

# unrecognized arguments: --instance-id 0

# all VMSS NICs
az vmss nic list \
    --resource-group automagic-vwan-vmss-spoke-aa41adff \
    --vmss-name vmss-spoke-aa41adff \
    --query "[].id" -o tsv

echo az network nic show-effective-route-table \
  --ids $(az vmss nic list \
    --resource-group automagic-vwan-vmss-spoke-aa41adff \
    --vmss-name vmss-spoke-aa41adff \
    --query "[0].id" -o tsv)

az network nic show --ids /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/automagic-vwan-vmss-spoke-aa41adff/providers/Microsoft.Compute/virtualMachineScaleSets/vmss-spoke-aa41adff/virtualMachines/0/networkInterfaces/eth0

az network nic show-effective-route-table \
  --ids $(az vmss nic list \
    --resource-group automagic-vwan-vmss-spoke-aa41adff \
    --vmss-name vmss-spoke-aa41adff \
    --query "[0].id" -o tsv)

az vmss nic list \
    --resource-group automagic-vwan-vmss-spoke-aa41adff \
    --vmss-name vmss-spoke-aa41adff

az vmss nic list \
  --resource-group automagic-vwan-vmss-spoke-aa41adff \
  --vmss-name vmss-spoke-aa41adff \
  --query "[].id" -o tsv

az vmss nic list   --resource-group automagic-vwan-vmss-spoke-aa41adff   --vmss-name vmss-spoke-aa41adff -o json | grep Microsoft.Network

az network nsg show --ids /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/automagic-vwan-vmss-spoke-aa41adff/providers/Microsoft.Network/networkSecurityGroups/automagic-vwan-vmss-spoke-aa41adff_nsg
az network nsg show --ids /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/automagic-vwan-vmss-spoke-aa41adff/providers/Microsoft.Network/networkSecurityGroups/automagic-vwan-vmss-spoke-aa41adff_nsg | jq -r ' .networkInterfaces[].id'

# /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/AUTOMAGIC-VWAN-VMSS-SPOKE-AA41ADFF/PROVIDERS/MICROSOFT.COMPUTE/VIRTUALMACHINESCALESETS/VMSS-SPOKE-AA41ADFF/VIRTUALMACHINES/0/NETWORKINTERFACES/ETH0

az network nic show-effective-route-table --ids /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/AUTOMAGIC-VWAN-VMSS-SPOKE-AA41ADFF/PROVIDERS/MICROSOFT.COMPUTE/VIRTUALMACHINESCALESETS/VMSS-SPOKE-AA41ADFF/VIRTUALMACHINES/0/NETWORKINTERFACES/ETH0

az vmss nic show-effective-route-table
# not existing


az network nic list --resource-group "automagic-vwan-vmss-spoke-$(cat ../../secrets/sp.json | jq -r .envId)" --query "[?starts_with(name, '<vmss-name>')]" --output table
az network nic list --resource-group "automagic-vwan-vmss-spoke-$(cat ./secrets/sp.json | jq -r .envId)" --output table
# no nics found

```