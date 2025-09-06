#!/bin/bash

set -euo pipefail

#RG=$(cd management/terraform; terraform output -raw rg)
#CPMAN_NAME=$(cd management/terraform; terraform output -raw name)

# /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/AUTOMAGIC-LINUX68-RG/providers/Microsoft.Compute/virtualMachines/linux68
RG="AUTOMAGIC-LINUX68-RG"
VMNAME="linux68"

echo "Connecting to serial console of ${VMNAME} in RG $RG"

az serial-console connect --resource-group $RG --name "${VMNAME}"