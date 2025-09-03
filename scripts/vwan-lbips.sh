#!/bin/bash

set -eu

TOKEN=$(az account get-access-token --query accessToken -o tsv)
# ls -l ./secrets/.env-cmeapi
source ./secrets/.env-cmeapi

# echo $NVA_NAME
# echo $NVA_RESOURCE_GROUP
# echo $READER_SUBSCRIPTION_ID
# echo $ENVID

# GET https://management.azure.com/subscriptions/{{subscriptionId}}/resourceGroups/{{nvaRg}}/providers/Microsoft.Network/networkVirtualAppliances/{{nvaName}}?api-version=2023-11-01
# Content-Type: application/json
# Authorization: Bearer {{token}}

NVADATA=$(curl -s -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     "https://management.azure.com/subscriptions/$READER_SUBSCRIPTION_ID/resourceGroups/$NVA_RESOURCE_GROUP/providers/Microsoft.Network/networkVirtualAppliances/$NVA_NAME?api-version=2023-11-01")

# echo "$NVADATA" | jq .

IPS=$(echo "$NVADATA" | jq -r '.properties.internetIngressPublicIps')
# echo $IPS | jq .

function pipDetails() {
    PIPID=$1

    PIPDATA=$(curl -s -H "Authorization: Bearer $TOKEN" \
         -H "Content-Type: application/json" \
         "https://management.azure.com${PIPID}?api-version=2024-05-01")

    echo "$PIPDATA" | jq .
}

echo $IPS | jq -r '.[] | .id' | while read PIPID; do
    PIPDETAIL=$(pipDetails "$PIPID")
    NAME=$(echo "$PIPDETAIL" | jq -r '.name')
    IP=$(echo "$PIPDETAIL" | jq -r '.properties.ipAddress')
    echo -e "$IP\t: $NAME"
done
