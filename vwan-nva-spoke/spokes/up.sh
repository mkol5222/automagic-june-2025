#!/bin/bash

set -euo pipefail


ROOT_DIR=/workspaces/automagic-june-2025
MODULE_DIR=$ROOT_DIR/vwan-nva-spoke/spokes
# if ~/.ssh/id_rsa.pub does not exist, create key without passphrase
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
fi

(cd $MODULE_DIR/; terraform init)

(cd $MODULE_DIR/; terraform apply -auto-approve )


(cd $MODULE_DIR/; terraform output -json)