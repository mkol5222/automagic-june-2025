#!/bin/bash

set -euo pipefail

export CHECKPOINT_SESSION_NAME="TF CME SETUP vWAN $(whoami) $(date) from $(hostname)"
export CHECKPOINT_SESSION_DESCRIPTION="Terraform session description"

PARENTDIR=/workspaces/automagic-june-2025
CPMANRG=$(cd "$PARENTDIR/management/terraform" && terraform output -raw rg)
CPMANNAME=$(cd "$PARENTDIR/management/terraform" && terraform output -raw name)
CPMANIP=$(az vm show -d --resource-group "$CPMANRG" --name "$CPMANNAME" --query "publicIps" -o tsv)
CPMANPASS=$(cd "$PARENTDIR/management/terraform"; terraform output -raw password)
# echo "Management IP: $CPMANIP   Password: $CPMANPASS"

export CHECKPOINT_SERVER="$CPMANIP"
export CHECKPOINT_USERNAME="admin"
export CHECKPOINT_PASSWORD="$CPMANPASS"
export CHECKPOINT_API_KEY=""

(cd vwan/cme; terraform init)
(cd vwan/cme; rm sid.json || true)
(cd vwan/cme; terraform init)
if (cd vwan/cme; terraform apply -auto-approve); then 
	echo "Terraform apply succeeded";
    export SID=$(cd vwan/cme; jq -r .sid ./sid.json)
	./scripts/publish.sh "$SID"; 
else
    echo "Terraform apply failed";
    export SID=$(cd vwan/cme; jq -r .sid ./sid.json)
	./scripts/discard.sh "$SID"; 
fi
echo "Policy: Done."

