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

##
# SIC key to base64
echo -n VP1hJ2q5UtsZ8ddp | base64 -w0

### CME cme_menu


# Enter Selection: 1


# Welcome To Cloud Guard CME in Azure Configuration
# 1) Automatic Hotfix Deployment
# 2) vWAN


# 3) Back
# 4) Exit (or Ctrl + C)

# Enter Selection: 2


# Welcome To vWAN automatic configuration script
# 1) Configure NVA gateways on management server
# 2) Show Metering Overview
# 3) Export Metering Data
# 4) Configure Metering for NVAs
# 5) Configure Ingress Rules (Preview)


# 6) Back
# 7) Exit (or Ctrl + C)


####

# LB PIP

az network public-ip show \
  --name am-vwan-nva-ipIngress \
  --resource-group am-vwan-nva-rg-ffeb4275 \
  --query "ipAddress" \
  -o tsv

mgmt_cli -r true --format json show host name vwanlbip

LBIP=$(az network public-ip show --name am-vwan-nva-ipIngress --resource-group am-vwan-nva-rg-ffeb4275 --query "ipAddress" -o tsv)
echo $LBIP

make cpman-ssh
export LBIP=20.223.168.168
mgmt_cli -r true --format json set host name vwanlbip ipv4-address "$LBIP"


###
while true; do ((cd vwan; terraform state list) | while read R; do (cd vwan; terraform destroy -auto-approve -target "$R";) done; sleep 5; ); done

# vyskoceni ze smycky, az nic nezbude je na Ctrl-C ;-)
