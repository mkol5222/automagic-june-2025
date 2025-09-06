#!/bin/bash

set -euo pipefail

PROJECT_ROOT=/workspaces/automagic-june-2025/

# TF_VAR_management_IP
CPMAN_RG=$(cd $PROJECT_ROOT/management/terraform; terraform output -raw rg)
CPMAN_NAME=$(cd $PROJECT_ROOT/management/terraform; terraform output -raw name)
CPMAN_IP=$(az vm show -d --resource-group "$CPMAN_RG" --name "$CPMAN_NAME" --query "publicIps" -o tsv)
export TF_VAR_management_IP="$CPMAN_IP"

# random password for VMSS sic key
VMSS_SIC_KEY=$(cat $PROJECT_ROOT/secrets/vmss-spoke-sic.txt 2>/dev/null || true)
if [[ -z "$VMSS_SIC_KEY" ]]; then
    echo "Generating random VMSS SIC key..."
    VMSS_SIC_KEY=$(openssl rand -base64 16 | tr -d '=/+')
    echo -n "$VMSS_SIC_KEY" > $PROJECT_ROOT/secrets/vmss-spoke-sic.txt
fi

export TF_VAR_sic_key="$VMSS_SIC_KEY"

terraform init
#terraform import module.linux208.azurerm_subnet_route_table_association.linux-rt-to-subnet /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/automagic-vwan-vmss-spoke-aa41adff/providers/Microsoft.Network/virtualNetworks/vmss-spoke-vnet/subnets/linux

terraform apply -auto-approve
