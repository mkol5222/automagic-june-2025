#!/bin/bash

set -eu

# cat ./secrets/sp.json | jq .
ENVID=$(cat ./secrets/sp.json | jq -r .envId)
# cat ./secrets/reader.json | jq .
READER_SUBSCRIPTION=$(cat ./secrets/reader.json | jq -r .subscriptionId)
READER_CLIENT_ID=$(cat ./secrets/reader.json | jq -r .appId)
READER_TENANT_ID=$(cat ./secrets/reader.json | jq -r .tenant)
READER_CLIENT_SECRET=$(cat ./secrets/reader.json | jq -r .password)

# if no ./secrets/vwan-nva-sic.txt
if [ ! -f ./secrets/vwan-nva-sic.txt ]; then
  echo "SIC key file not found! (./secrets/vwan-nva-sic.txt) Deploy vWAN ('time make vwan-up') first."
  exit 1
fi

SICKEY=$(cat ./secrets/vwan-nva-sic.txt)
SICKEYB64=$(echo -n "$SICKEY" | base64 -w0)

# is there management aka cpman? look for az rg named automagic-cpman-$ENVID
if az group show --name "automagic-cpman-${ENVID}" > /dev/null 2>&1; then
  echo "Management resource group found."
else
  echo "Management resource group not found. Deploy management with 'time make cpman' first"
  exit 1
fi

cat << EOF
ENVID="$ENVID"
READER_SUBSCRIPTION_ID="$READER_SUBSCRIPTION"
READER_CLIENT_ID="$READER_CLIENT_ID"
READER_TENANT_ID="$READER_TENANT_ID"
READER_CLIENT_SECRET="$READER_CLIENT_SECRET"

NVA_AZ_ACCOUNT=myazure
NVA_RESOURCE_GROUP="automagic-vwan-nva-${ENVID}"
NVA_NAME=am-vwan-nva
NVA_POLICY=vmss
# base64 encoded! - echo -n realsic | base -w0
NVA_SICKEY="$SICKEYB64"

CHECKPOINT_SERVER=192.168.1.1
CHECKPOINT_USERNAME=admin
CHECKPOINT_PASSWORD="real management password"

LB_IP="real lb ip"
EOF


# # IP or hostname
# CHECKPOINT_SERVER=192.168.1.1
# CHECKPOINT_USERNAME=admin
# CHECKPOINT_PASSWORD="real management password"
# READER_SUBSCRIPTION_ID="real reader subscription id"
# READER_CLIENT_ID="real reader client id"
# READER_TENANT_ID="real tenant id"
# READER_CLIENT_SECRET="real reader client secret"

# NVA_AZ_ACCOUNT=myazure
# NVA_RESOURCE_GROUP=am-vwan-nva-rg-ffeb4275
# NVA_NAME=am-vwan-nva
# NVA_POLICY=vmss
# # base64 encoded! - echo -n realsic | base -w0
# NVA_SICKEY="VlAxaEoycTVVdHNaOGRkcA=="

# # inbound rules
# # az network public-ip show --name am-vwan-nva-ipIngress --resource-group am-vwan-nva-rg-ffeb4275 --query "ipAddress" -o tsv
# LB_IP="real lb ip"