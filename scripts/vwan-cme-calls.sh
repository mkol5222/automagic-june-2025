#!/bin/bash

# if not found
if [ ! -f ./secrets/.env-cmeapi ]; then
  echo "Environment file  -f ./secrets/.env-cmeapi not found!"
  exit 1
fi

source ./secrets/.env-cmeapi

# POST https://{{$dotenv CHECKPOINT_SERVER}}/web_api/login
# Content-Type: application/json

# {
#     "user": "{{$dotenv CHECKPOINT_USERNAME}}",
#     "password": "{{$dotenv CHECKPOINT_PASSWORD}}"
# }

function login() {
  RESP=$(curl -k -X POST "https://$CHECKPOINT_SERVER/web_api/login" \
  -H "Content-Type: application/json" \
  -d '{
      "user": "'"$CHECKPOINT_USERNAME"'",
      "password": "'"$CHECKPOINT_PASSWORD"'"
  }' -s)
  SID=$(echo "$RESP" | jq -r .sid)
  # echo "$SID"
}

# POST https://{{$dotenv CHECKPOINT_SERVER}}/web_api/cme-api/v1.2/accounts/azure
# Content-Type: application/json
# X-chkp-sid: {{login.response.body.sid}}

# {
#     "name": "myazure",
#     "subscription": "{{$dotenv READER_SUBSCRIPTION_ID}}",
#     "application_id": "{{$dotenv READER_CLIENT_ID}}",
#     "directory_id": "{{$dotenv READER_TENANT_ID}}",
#     "client_secret": "{{$dotenv READER_CLIENT_SECRET}}"
# }
function addAccount() {
  RESP_ADD_ACC=$(curl -k -X POST "https://$CHECKPOINT_SERVER/web_api/cme-api/v1.2/accounts/azure" \
  -H "Content-Type: application/json" \
  -H "X-chkp-sid: $SID" \
  -d '{
      "name": "myazure",
      "subscription": "'"$READER_SUBSCRIPTION_ID"'",
      "application_id": "'"$READER_CLIENT_ID"'",
      "directory_id": "'"$READER_TENANT_ID"'",
      "client_secret": "'"$READER_CLIENT_SECRET"'"
  }' -s)
  echo "$RESP_ADD_ACC"

#   {
#   "result" : { },
#   "error" : { },
#   "status-code" : 200
# }
}

function deleteAccount() {
  RESP_DEL_ACC=$(curl -k -X DELETE "https://$CHECKPOINT_SERVER/web_api/cme-api/v1.2/accounts/azure/myazure" \
  -H "Content-Type: application/json" \
  -H "X-chkp-sid: $SID" \
  -s)
  echo "$RESP_DEL_ACC"

#   {
#   "result" : { },
#   "error" : { },
#   "status-code" : 200
# }
}


function setAccount() {
  RESP_SET_ACC=$(curl -k -X PUT "https://$CHECKPOINT_SERVER/web_api/cme-api/v1.2/accounts/azure/myazure" \
  -H "Content-Type: application/json" \
  -H "X-chkp-sid: $SID" \
  -d '{
      "subscription": "'"$READER_SUBSCRIPTION_ID"'",
      "application_id": "'"$READER_CLIENT_ID"'",
      "directory_id": "'"$READER_TENANT_ID"'",
      "client_secret": "'"$READER_CLIENT_SECRET"'"
  }' -s)
  echo "$RESP_SET_ACC"

#   {
#   "result" : { },
#   "error" : { },
#   "status-code" : 200
# }
}

# GET https://{{$dotenv CHECKPOINT_SERVER}}/web_api/cme-api/v1.2/accounts
# Content-Type: application/json
# X-chkp-sid: {{login.response.body.sid}}

function listAccounts() {
    RESP_LIST_ACC=$(curl -k -X GET "https://$CHECKPOINT_SERVER/web_api/cme-api/v1.2/accounts" \
    -H "Content-Type: application/json" \
    -H "X-chkp-sid: $SID" \
    -s)
    echo "$RESP_LIST_ACC"
}

# POST https://{{$dotenv CHECKPOINT_SERVER}}/web_api/v1.8/cme-api/v1.2.1/azure/virtualWANs/accounts/{{azAccount}}/resourceGroups/{{nvaResourceGroup}}/provision/{{nvaName}}
# Content-Type: application/json
# X-chkp-sid: {{login.response.body.sid}}

# {
#     "base64_sic_key": "{{nvaSicKey}}",
#     "policy": "{{nvaPolicy}}",
#     "autonomous_threat_prevention": true,
#     "identity_awareness": true
# }
function addAzureNVAs() {
    RESP_ADD_NVA=$(curl -k -X POST "https://$CHECKPOINT_SERVER/web_api/v1.8/cme-api/v1.2.1/azure/virtualWANs/accounts/myazure/resourceGroups/myResourceGroup/provision/myNva" \
    -H "Content-Type: application/json" \
    -H "X-chkp-sid: $SID" \
    -d '{
        "base64_sic_key": "'"$NVA_SICKEY"'",
        "policy": "'"$NVA_POLICY"'",
        "autonomous_threat_prevention": true,
        "identity_awareness": true
    }' -s)
    echo "$RESP_ADD_NVA"
}

# GET https://{{$dotenv CHECKPOINT_SERVER}}/web_api/cme-api/status/{{requestId}}
# Content-Type: application/json
# X-chkp-sid: {{login.response.body.sid}}
function checkStatus() {
    REQID=$1
    RESP_CHECK_STATUS=$(curl -k -X GET "https://$CHECKPOINT_SERVER/web_api/cme-api/status/$REQID" \
    -H "Content-Type: application/json" \
    -H "X-chkp-sid: $SID" \
    -s)
    echo "$RESP_CHECK_STATUS"
}

login
# echo $SID

deleteAccount
sleep 2
addAccount
sleep 2
setAccount

sleep 2
listAccounts
sleep 2
ADDNVARES=$(addAzureNVAs)
ADDNVARES_REQID=$(echo "$ADDNVARES" | jq -r '.result."request-id"')
echo "ADDNVARES: >>>$ADDNVARES<<<"
echo
sleep 5
echo "Checking status of $ADDNVARES_REQID"
checkStatus "$ADDNVARES_REQID"
