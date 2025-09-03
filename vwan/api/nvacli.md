# NVA CLI

```bash

RG=$(az group list -o json | jq -r '.[] |select(.name | contains("automagic-vwan-nva")) |.name')
SUBSCRIPTION_ID=$(az account show -o json | jq -r '.id')

az network virtual-appliance list --resource-group $RG

NVA_NAME=$(az network virtual-appliance list --resource-group $RG -o json | jq -r '.[0] | .name')
echo $NVA_NAME
NVA_ID=$(az network virtual-appliance list --resource-group $RG -o json | jq -r '.[0] | .id')
echo "$NVA_ID"

az network virtual-appliance --help
az network virtual-appliance show --help

az network virtual-appliance show --ids "$NVA_ID"
az network virtual-appliance show --ids "$NVA_ID" --debug
az network virtual-appliance show --ids "$NVA_ID" | jq '.|keys'

az network virtual-appliance show --ids "$NVA_ID" | jq '.inboundSecurityRules'
az network virtual-appliance show --ids "$NVA_ID" | jq '.internetIngressPublicIps'

az network virtual-appliance inbound-security-rule  --help
az network virtual-appliance inbound-security-rule  show --help

# az network virtual-appliance inbound-security-rule show -ids "$NVA_ID/inboundSecurityRules/$NVA_NAME" -n "am-vwan-nva"
# az network virtual-appliance inbound-security-rule show --nva-name "MyName" -g "MyRG" --subscription {subID} --name "InboundRuleCollection"

az network virtual-appliance inbound-security-rule show --nva-name "$NVA_NAME" -g "$RG" --subscription "$SUBSCRIPTION_ID" --name "$NVA_NAME"

az rest --method get --url "https://management.azure.com/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RG}/providers/Microsoft.Network/networkVirtualAppliances/${NVA_NAME}/inboundSecurityRules/${NVA_NAME}?api-version=2024-05-01"

