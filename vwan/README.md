# Azure vWAN lab

* get admin credentials in [Azure Shell](https://shell.azure.com/)

```bash
### IN AZURE SHELL ###
# check the script before running
curl -sL https://run.klaud.online/make-sp.sh
# create credentials
source <(curl -sL https://run.klaud.online/make-sp.sh)
# it produced JSON to be placed to secrets/sp.json
```

* back in Codespace/DevContainer - login with admin SP using `make sp-login` after checking that `./secrets/sp.json` is present with `cat ./secrets/sp.json | jq .`

* get reader SP in [Azure Shell](https://shell.azure.com/) using
```bash
az ad sp create-for-rbac --name "automagic-reader-$(openssl rand -hex 4)" --role Reader --scopes "/subscriptions/$(az account show --query id --output tsv)" | tee reader.json
```

* upgrade privileges for CME reader to manage NVA inbound rules in [Azure Shell](https://shell.azure.com/) using

```bash
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.nva-rg}"
  role_definition_name = "Network Contributor"
```