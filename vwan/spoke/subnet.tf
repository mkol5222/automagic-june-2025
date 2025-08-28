
# subnet in the VNET /24

resource "azurerm_subnet" "spoke_subnet" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  # calculate from var vnet_address 10.77.0.0/16 = 10.77.1.0/24
  address_prefixes     = [cidrsubnet(var.vnet_address, 8, 1)]
}
