#!/bin/bash

set -euo pipefail





(cd vwan/pip; terraform destroy -auto-approve )


echo "Remaining state for vwan/pip:"
(cd vwan/pip; terraform state list)
echo "---"
