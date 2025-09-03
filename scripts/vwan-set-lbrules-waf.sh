#!/bin/bash

set -eu

TOKEN=$(az account get-access-token --query accessToken -o tsv)
# ls -l ./secrets/.env-cmeapi
source ./secrets/.env-cmeapi

# echo $NVA_NAME
# echo $NVA_RESOURCE_GROUP
# echo $READER_SUBSCRIPTION_ID
# echo $ENVID

# PUT https://management.azure.com/subscriptions/{{subscriptionId}}/resourceGroups/{{nvaRg}}/providers/Microsoft.Network/networkVirtualAppliances/{{nvaName}}/inboundSecurityRules/{{nvaName}}?api-version=2024-05-01
# Authorization: Bearer {{token}}
# Content-Type: application/json

# { "properties": {
#     "ruleType": "Permanent",
#     "rules": [
#       {
#         "name": "web_linux77",
#         "protocol": "TCP",
#         "sourceAddressPrefix": "0.0.0.0/0",
#         "destinationPortRanges": [
#           "80",
#           "443",
#           "22",
#           "8080"
#         ],
#         "appliesOn": [
#           "am-vwan-nva-ipIngress"
#         ],
#         "access": "allow"
#       }
#     ]
#     }
# }
# vwan-lb-a-pip
curl -s -X PUT -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -d '{
       "properties": {
         "ruleType": "Permanent",
         "rules": [
           {
             "name": "web_linux77",
             "protocol": "TCP",
             "sourceAddressPrefix": "0.0.0.0/0",
             "destinationPortRanges": [
               "80",
               "443",
               "22",
               "8080"
             ],
             "appliesOn": [
               "am-vwan-nva-ipIngress"
             ],
             "access": "allow"
           },
                      {
             "name": "web_waf77",
             "protocol": "TCP",
             "sourceAddressPrefix": "0.0.0.0/0",
             "destinationPortRanges": [
               "80",
               "443"
             ],
             "appliesOn": [
               "vwan-lb-a-pip"
             ],
             "access": "allow"
           }

         ]
       }
     }' \
     "https://management.azure.com/subscriptions/$READER_SUBSCRIPTION_ID/resourceGroups/$NVA_RESOURCE_GROUP/providers/Microsoft.Network/networkVirtualAppliances/$NVA_NAME/inboundSecurityRules/$NVA_NAME?api-version=2024-05-01"

echo; echo

function getNvaRulesFull() {
     NVARULES=$(curl -s -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     "https://management.azure.com/subscriptions/$READER_SUBSCRIPTION_ID/resourceGroups/$NVA_RESOURCE_GROUP/providers/Microsoft.Network/networkVirtualAppliances/$NVA_NAME/inboundSecurityRules/$NVA_NAME?api-version=2024-05-01" )

     echo "$NVARULES" | jq .
}

while true; do
     PROVSTATE=$(getNvaRulesFull | jq -r .properties.provisioningState)
     echo "$PROVSTATE"
     # not updating , break
     if [ "$PROVSTATE" != "Updating" ]; then
         break
     fi
     sleep 5
done
