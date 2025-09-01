#!/bin/bash

set -euo pipefail

export CHECKPOINT_SESSION_NAME="TF $(whoami) $(date) from $(hostname)"
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

(cd policy/terraform; terraform init)
(cd policy/terraform; rm sid.json || true)
(cd policy/terraform; terraform init)
if (cd policy/terraform; terraform apply -auto-approve -target checkpoint_management_nat_rule.rule125 -target checkpoint_management_nat_rule.rule126); then 
	echo "Terraform apply succeeded";
    export SID=$(cd policy/terraform; jq -r .sid ./sid.json)
	./scripts/publish.sh "$SID"; 
else
    echo "Terraform apply failed";
    export SID=$(cd policy/terraform; jq -r .sid ./sid.json)
	./scripts/discard.sh "$SID"; 
fi
echo "Policy: Done."

