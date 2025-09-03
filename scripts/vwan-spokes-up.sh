#!/bin/bash

set -euo pipefail


# if ~/.ssh/id_rsa.pub does not exist, create key without passphrase
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
fi

(cd vwan/spokes/; terraform init)

(cd vwan/spokes/; terraform apply -auto-approve )


(cd vwan/spokes/; terraform output -json)