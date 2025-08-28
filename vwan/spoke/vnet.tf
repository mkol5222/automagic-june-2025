
resource "azurerm_resource_group" "rg" {
  name     = var.vnet_rg
  location = data.azurerm_virtual_hub.vwan_hub.location
}

# Create Spoke VNET
resource "azurerm_virtual_network" "spoke" {
  name                = var.vnet_name
  location            = data.azurerm_virtual_hub.vwan_hub.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet_address]
}

# Optional subnet (needed for workloads/gateways)
# resource "azurerm_subnet" "spoke77_subnet" {
#   name                 = "subnet1"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.spoke77.name
#   address_prefixes     = ["10.77.1.0/24"]
# }

# Connect spoke VNET to Virtual Hub
resource "azurerm_virtual_hub_connection" "spoke_to_hub" {
  name                      = "conn-${var.vnet_name}-to-hub"
  virtual_hub_id            = data.azurerm_virtual_hub.vwan_hub.id
  remote_virtual_network_id = azurerm_virtual_network.spoke.id

  internet_security_enabled = true
}
