

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



data "http" "vmss_conn" {
  url = "https://management.azure.com${local.vmss_conn_id}?api-version=2022-05-01"
  request_headers = {
    Authorization = "Bearer ${local.azure_token}"
  }
}

#  "/subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/automagic-vwan-hub-aa41adff/providers/Microsoft.Network/virtualHubs/automagic-cgns-hub-aa41adff/hubVirtualNetworkConnections/conn-vmss-spoke-vnet-to-hub"
locals {
    hub_rg = "automagic-vwan-hub-${local.secrets.envId}"
    hub_name = "automagic-cgns-hub-${local.secrets.envId}"
    conn_name = "conn-vmss-spoke-vnet-to-hub"
    azure_subscription_id = local.secrets.subscriptionId # data.azurerm_client_config.current.subscription_id

    vmss_conn_id = "/subscriptions/${local.azure_subscription_id}/resourceGroups/${local.hub_rg}/providers/Microsoft.Network/virtualHubs/${local.hub_name}/hubVirtualNetworkConnections/${local.conn_name}"
    vmss_conn_respbody = jsondecode(data.http.vmss_conn.body)
    vmss_conn_resp_error = try(local.vmss_conn_respbody.error, null) != null ? true : false
}

output "vmss_conn_id" {
  value = local.vmss_conn_id
}