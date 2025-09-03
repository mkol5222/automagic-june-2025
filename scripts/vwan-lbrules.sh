#!/bin/bash

set -eu

TOKEN=$(az account get-access-token --query accessToken -o tsv)
# ls -l ./secrets/.env-cmeapi
source ./secrets/.env-cmeapi

# echo $NVA_NAME
# echo $NVA_RESOURCE_GROUP
# echo $READER_SUBSCRIPTION_ID
# echo $ENVID

# GET https://management.azure.com/subscriptions/{{subscriptionId}}/resourceGroups/{{nvaRg}}/providers/Microsoft.Network/networkVirtualAppliances/{{nvaName}}/inboundSecurityRules/{{nvaName}}?api-version=2024-05-01
# Authorization: Bearer {{token}}

NVARULES=$(curl -s -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     "https://management.azure.com/subscriptions/$READER_SUBSCRIPTION_ID/resourceGroups/$NVA_RESOURCE_GROUP/providers/Microsoft.Network/networkVirtualAppliances/$NVA_NAME/inboundSecurityRules/$NVA_NAME?api-version=2024-05-01" \
     | jq .properties.rules)

echo "$NVARULES" | jq .



