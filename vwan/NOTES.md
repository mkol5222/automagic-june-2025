```bash

cd /workspaces/automagic-june-2025/vwan
terraform state list
terraform state show module.vwan.azapi_resource.managed-app

terraform output -json
# SIC key
# SSH key


# https://learn.microsoft.com/en-us/cli/azure/network/virtual-appliance?view=azure-cli-latest
az network virtual-appliance list -o table

az network virtual-appliance list -o json 

az network virtual-appliance list -o json | jq '.[] | .virtualApplianceNics'

terraform destroy -auto-approve -target module.linux77
terraform destroy -auto-approve -target module.spoke77

terraform apply -auto-approve -target module.spoke77
terraform apply -auto-approve -target module.linux77

###

az network vhub list --output table

# AddressPrefix    AllowBranchToBranchTraffic    HubRoutingPreference    Location     Name         ProvisioningState    ResourceGroup            RoutingState    VirtualRouterAsn
# ---------------  ----------------------------  ----------------------  -----------  -----------  -------------------  -----------------------  --------------  ------------------
# 10.0.0.0/16      False                         ExpressRoute            northeurope  am-vwan-hub  Succeeded            automagic-vwan-ffeb4275  Provisioned     65515


az network vhub connection list \
    --vhub-name  am-vwan-hub \
    --resource-group automagic-vwan-ffeb4275 \
    --output table

# AllowHubToRemoteVnetTransit    AllowRemoteVnetToUseHubVnetGateways    EnableInternetSecurity    Name                  ProvisioningState    ResourceGroup
# -----------------------------  -------------------------------------  ------------------------  --------------------  -------------------  -----------------------
# True                           True                                   True                      conn-myVNet77-to-hub  Succeeded            automagic-vwan-ffeb4275

az network vhub connection list \
    --vhub-name  am-vwan-hub \
    --resource-group automagic-vwan-ffeb4275 \
    --output json

# list all vnets
az network vnet list --output table

# list all VMs
az vm list --output table

# in TF
terraform apply -auto-approve -target module.assets ; cat /tmp/vwan.json | jq .