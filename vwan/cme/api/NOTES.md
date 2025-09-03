

```bash

pwd
cd /workspaces/automagic-june-2025/vwan/cme/api

ls /workspaces/automagic-june-2025/secrets/.env-cmeapi
ls ../../../secrets/.env-cmeapi
head ../../../secrets/.env-cmeapi

head .env
#(cd /workspaces/automagic-june-2025; ./scripts//vwan-cme-api-env.sh)
(cd /workspaces/automagic-june-2025; make vwan-cme-up)
cp ../../../secrets/.env-cmeapi .env
code /workspaces/automagic-june-2025/vwan/cme/api/cme-vwan.http