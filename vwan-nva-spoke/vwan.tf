
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
  

resource "azurerm_virtual_hub_route_table" "hub-default" {

count = local.vmss_conn_resp_error ? 0 : 1

  name           = "hub-default"
  virtual_hub_id = azurerm_virtual_hub.automagic-hub.id
  # labels         = ["label1"]

  route {
    name              = "default-route"
    destinations_type = "CIDR"
    destinations      = ["0.0.0.0/0"]
    next_hop_type     = "ResourceId"
    next_hop          = local.vmss_conn_id
  }
}