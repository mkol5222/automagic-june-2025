#!/bin/bash


PROJECT_DIR=/workspaces/automagic-june-2025

# get (read-only) credentials to list VMSS in Azure 
CLIENT_ID=$(cat $PROJECT_DIR/secrets/reader.json | jq -r .appId)
CLIENT_SECRET=$(cat $PROJECT_DIR/secrets/reader.json | jq -r .password)
TENANT_ID=$(cat $PROJECT_DIR/secrets/reader.json | jq -r .tenant)
SUBSCRIPTION_ID=$(cat $PROJECT_DIR/secrets/sp.json | jq -r .subscriptionId)


ENVID=$(jq -r .envId $PROJECT_DIR/secrets/sp.json)
RG="automagic-vwan-vmss-spoke-$ENVID"
#az group list -o table | grep vmss
VMSS_NAME=$(az vmss list -g $RG --query "[].{name:name}" -o tsv)
echo "VMSS name is $VMSS_NAME"

az vmss list-instance-public-ips --name "$VMSS_NAME" -g $RG -o table

FIRST_IP=$(az vmss list-instance-public-ips --name "$VMSS_NAME" -g $RG --query "[0].ipAddress" -o tsv)
SECOND_IP=$(az vmss list-instance-public-ips --name "$VMSS_NAME" -g $RG --query "[1].ipAddress" -o tsv)
echo "First VMSS instance IP is $FIRST_IP"
echo "Second VMSS instance IP is $SECOND_IP"

(cd $PROJECT_DIR/vwan-nva-spoke/vmss-spoke; terraform output -raw admin_password ); echo
# (cd $PROJECT_DIR/vwan-nva-spoke/vmss-spoke; terraform output )

ssh admin@$FIRST_IP