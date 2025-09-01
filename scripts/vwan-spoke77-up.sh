#!/bin/bash

set -euo pipefail


# if ~/.ssh/id_rsa.pub does not exist, create key without passphrase
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
fi

(cd vwan; terraform init)

(cd vwan; terraform apply -auto-approve -target module.spoke77)
(cd vwan; terraform apply -auto-approve -target module.linux77)

(cd vwan; terraform output -json)