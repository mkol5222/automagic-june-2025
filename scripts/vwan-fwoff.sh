#!/bin/bash

set -eu

TOKEN=$(az account get-access-token --query accessToken -o tsv)
# ls -l ./secrets/.env-cmeapi
source ./secrets/.env-cmeapi

# echo $NVA_NAME
# echo $NVA_RESOURCE_GROUP
# echo $READER_SUBSCRIPTION_ID
# echo $ENVID

# @nvaId=/subscriptions/{{subscriptionId}}/resourcegroups/{{nvaRg}}/providers/Microsoft.Network/networkVirtualAppliances/{{nvaName}}
NVA_ID=/subscriptions/$READER_SUBSCRIPTION_ID/resourceGroups/$NVA_RESOURCE_GROUP/providers/Microsoft.Network/networkVirtualAppliances/$NVA_NAME
echo $NVA_ID


curl -s -X DELETE -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     "https://management.azure.com/subscriptions/${READER_SUBSCRIPTION_ID}/resourceGroups/${HUB_RG_NAME}/providers/Microsoft.Network/virtualHubs/${HUB_NAME}/routingIntent/hubRoutingIntent?api-version=2023-06-01"


function getRoutingIntent() {
     curl -s -H "Authorization: Bearer $TOKEN" \
          -H "Content-Type: application/json" \
          "https://management.azure.com/subscriptions/${READER_SUBSCRIPTION_ID}/resourceGroups/${HUB_RG_NAME}/providers/Microsoft.Network/virtualHubs/${HUB_NAME}/routingIntent/hubRoutingIntent?api-version=2023-06-01"
}

# getRoutingIntent | jq .
# properties":{"provisioningState

while true; do
     PROVSTATE=$(getRoutingIntent | jq -r .properties.provisioningState)
     echo "$PROVSTATE"
     # not updating , break
     if [ "$PROVSTATE" != "Deleting" ]; then
         break
     fi
     sleep 5
done