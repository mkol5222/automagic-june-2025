



data "azurerm_virtual_hub" "lab" {
  name                = "am-vwan-hub"
  resource_group_name = "automagic-vwan-ffeb4275"
}

# data "azurerm_virtual_network" "vnet77" {
#   name                = "myVNet77"
#   resource_group_name = "automagic-vwan-ffeb4275"
# }


// data hub all connections
# data "azurerm_virtual_hub_connections" "example" {
#   virtual_hub_name    = data.azurerm_virtual_hub.lab.name
#   resource_group_name = data.azurerm_virtual_hub.lab.resource_group_name
# }

# output "vhub_connections" {
#   value = data.azurerm_virtual_hub_connections.example
# }