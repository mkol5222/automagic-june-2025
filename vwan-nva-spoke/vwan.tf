
resource "azurerm_virtual_wan" "automagic-vwan" {
  name                = "automagic-cgns-vwan-${local.secrets.envId}"
  resource_group_name = azurerm_resource_group.automagic-vwan-hub-rg.name
  location            = var.location
}

resource "azurerm_virtual_hub" "automagic-hub" {
  name                = "automagic-cgns-hub-${local.secrets.envId}"
  resource_group_name = azurerm_resource_group.automagic-vwan-hub-rg.name
  location            = var.location
  virtual_wan_id      = azurerm_virtual_wan.automagic-vwan.id
  address_prefix      = "10.0.0.0/24"
}
  