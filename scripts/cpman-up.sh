#!/bin/bash

set -euo pipefail


az vm image terms accept \
  --publisher checkpoint \
  --offer check-point-cg-r82 \
  --plan mgmt-byol -o table

(cd management/terraform; terraform init)

(cd management/terraform; terraform apply -auto-approve)