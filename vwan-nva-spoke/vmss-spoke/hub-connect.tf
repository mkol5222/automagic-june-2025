
# locals {
#   this_spoke_vnet_id = azurerm_virtual_network.vmss_spoke_vnet.id
#   hub_id            = azurerm_virtual_hub.vwan_hub.id
# }

resource "azurerm_virtual_hub_connection" "spoke_to_hub" {
    count = local.create_connection ? 1 : 0
  name                      = "conn-vmss-spoke-vnet-to-hub"
  virtual_hub_id            = local.hub_id
  remote_virtual_network_id = local.spoke_vnet_id

  internet_security_enabled = false
}

locals {
    hub_rg = "automagic-vwan-hub-${local.secrets.envId}"
    hub_name = "automagic-cgns-hub-${local.secrets.envId}"
    spoke_rg = "automagic-vwan-vmss-spoke-${local.secrets.envId}"
    spoke_vnet_name = "vmss-spoke-vnet"
}

# rertrieve azure api token from provider
# data "azurerm_client_config" "current" {}

locals {
    # azure_token = data.azurerm_client_config.current.access_token
    azure_tenant_id = local.secrets.tenant # data.azurerm_client_config.current.tenant_id
    azure_subscription_id = local.secrets.subscriptionId # data.azurerm_client_config.current.subscription_id
    hub_id = "/subscriptions/${local.azure_subscription_id}/resourceGroups/${local.hub_rg}/providers/Microsoft.Network/virtualHubs/${local.hub_name}"
    spoke_vnet_id = "/subscriptions/${local.azure_subscription_id}/resourceGroups/${local.spoke_rg}/providers/Microsoft.Network/virtualNetworks/${local.spoke_vnet_name}"
}

provider "http" {}


  # subscription_id = local.spfile.subscriptionId
  # tenant_id       = local.spfile.tenant
  # client_id       = local.spfile.appId
  # client_secret   = local.spfile.password

data "http" "access_token" {
  method = "POST"
  url    = "https://login.microsoftonline.com/${local.secrets.tenant}/oauth2/v2.0/token"

  request_headers = {
    Content-Type = "application/x-www-form-urlencoded"
  }

  request_body = "grant_type=client_credentials&client_id=${local.secrets.appId}&client_secret=${local.secrets.password}&scope=https://management.azure.com/.default"
}

locals {
  azure_token = jsondecode(data.http.access_token.body).access_token
}

# use api to fetch vhub anf vnet details
data "http" "vhub" {
  url = "https://management.azure.com${local.hub_id}?api-version=2022-05-01"
  request_headers = {
    Authorization = "Bearer ${local.azure_token}"
  }
}

data "http" "spoke_vnet" {
  url = "https://management.azure.com${local.spoke_vnet_id}?api-version=2021-05-01"
  request_headers = {
    Authorization = "Bearer ${local.azure_token}"
  }
}

# extract VMSS ID from the response
locals {
  vnet_resp_body = jsondecode(data.http.spoke_vnet.body)
  vnet_resp_error = try(local.vnet_resp_body.error, null) != null ? true : false
  vmss_vnet_id = local.vnet_resp_error ? null : local.vnet_resp_body.id
  vmss_vnet_name = local.vnet_resp_error ? null : local.vnet_resp_body.name

  hub_resp_body = jsondecode(data.http.vhub.body)
  hub_resp_error = try(local.hub_resp_body.error, null) != null ? true : false
  vhub_id = local.hub_resp_error ? null : local.hub_resp_body.id
  vhub_name = local.hub_resp_error ? null : local.hub_resp_body.name

  create_connection = !local.vnet_resp_error && !local.hub_resp_error ? true : false
}

output "debug" {
    value = {
        create_connection = local.create_connection
        vhub_error = local.hub_resp_error
        vnet_error = local.vnet_resp_error
        hub = jsondecode(data.http.vhub.body)
        spoke_vnet = jsondecode(data.http.spoke_vnet.body)
    }
}