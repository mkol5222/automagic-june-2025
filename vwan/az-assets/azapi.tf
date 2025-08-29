terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}
provider "azapi" {
}
data "azapi_client_config" "current" {
}
output "subscription_id" {
  value = data.azapi_client_config.current.subscription_id
}
output "tenant_id" {
  value = data.azapi_client_config.current.tenant_id
}

// az network vhub list --output table
data "azapi_resource_list" "vhubs" {
    type = "Microsoft.Network/virtualHubs@2022-05-01"
    parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}"
}

locals {

    hubs_raw = data.azapi_resource_list.vhubs.output.value
    // objects hub name and rg from data.azapi_resource_list.vhubs
    hubs = { for hub in local.hubs_raw : hub.name => { name = hub.name, id = hub.id } }

    connections_data = data.azapi_resource_list.vhub_connections
    hub_connections = {
      for hub in local.hubs_raw :
      hub.name => (
        // each data.azapi_resource_list entry has an output.value which is a list of connection objects;
        // convert that list to a list of their .properties (or empty list if no connections)
        local.connections_data[hub.name] == null ? [] : [for conn in local.connections_data[hub.name].output.value : conn.properties.remoteVirtualNetwork.id]
      )
    }
}

// debug file /tmp/vwan.json
resource "local_file" "vwan_debug" {
  content = jsonencode({
    # hubs_raw = local.hubs
    hubs = local.hubs

    hub_connections = local.hub_connections

  })
  filename = "/tmp/vwan.json"
}

# terraform state list | grep vhubs
# module.assets.data.azapi_resource_list.vhubs

# terraform state show module.assets.data.azapi_resource_list.vhubs


# az network vhub connection list \
#     --vhub-name  am-vwan-hub \
#     --resource-group automagic-vwan-ffeb4275 \
#     --output json

# https://management.azure.com:443 "GET /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/automagic-vwan-ffeb4275/providers/Microsoft.Network/virtualHubs/am-vwan-hub/hubVirtualNetworkConnections?api-version=2022-07-01 
data "azapi_resource_list" "vhub_connections" {
    for_each = local.hubs
    # type vhub connections
    type="Microsoft.Network/virtualHubs/hubVirtualNetworkConnections@2022-07-01"
    parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/automagic-vwan-ffeb4275/providers/Microsoft.Network/virtualHubs/${each.value.name}"
}

# az network vhub connection list --debug --vhub-name  am-vwan-hub --resource-group automagic-vwan-ffeb4275 --output json
# terraform state show module.assets.data.azapi_resource_list.vhub_connections