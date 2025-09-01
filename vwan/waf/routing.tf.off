resource "azurerm_route_table" "linux-rt" {
  name                = "linux-rt-tf"
  location            = azurerm_resource_group.linux.location
  resource_group_name = azurerm_resource_group.linux.name
  #disable_bgp_route_propagation = false


  #   route {
  #     name                   = "to-aks"
  #     address_prefix         = "10.68.1.0/24"
  #     next_hop_type          = "VirtualAppliance"
  #     next_hop_in_ip_address = "10.68.11.4"
  #   }

  route {
    name           = "route-to-my-pub-ip"
    address_prefix = "${data.http.myip.response_body}/32"
    next_hop_type  = "Internet"
  }

  #   route {
  #     name           = "to-internet"
  #     address_prefix = "0.0.0.0/0"
  #     next_hop_type  = "Internet"
  #   }




  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_subnet_route_table_association" "linux-rt-to-subnet" {
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.linux-rt.id
}