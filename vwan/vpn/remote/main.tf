resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-remote"
  location = var.location
}

resource "azurerm_virtual_network" "remote" {
  name                = "${var.prefix}-remote-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.100.0.0/16"]
}