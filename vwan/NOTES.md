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
