#!/bin/bash

set -euo pipefail


ROOT_DIR=/workspaces/automagic-june-2025
MODULE_DIR=$ROOT_DIR/vwan-nva-spoke/spokes

(cd $MODULE_DIR/; terraform destroy -auto-approve )

echo "remaining state"
(cd $MODULE_DIR/; terraform state list)
echo "---"