#!/bin/bash

set -euo pipefail


# if ~/.ssh/id_rsa.pub does not exist, create key without passphrase
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
fi

(cd vwan; terraform init)

(cd vwan; terraform apply -auto-approve -target module.vwan -target lcoal_file.vwan_nva_sic)

(cd vwan; terraform output -json)