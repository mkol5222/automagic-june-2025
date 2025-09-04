#!/bin/bash

set -euo pipefail



(cd vwan/pip; terraform init)

(cd vwan/pip; terraform apply -auto-approve )


(cd vwan/pip; terraform output -json)

echo "PIP: Done."

echo "vWAN config for CME and API calls:"
./scripts/vwan-cme-api-env.sh

echo "Listing LB IPs:"
./scripts/vwan-lbips.sh
echo "Rules:"
./scripts/vwan-lbrules.sh