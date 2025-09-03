#!/bin/bash

set -euo pipefail



(cd vwan/spokes; terraform destroy -auto-approve)

