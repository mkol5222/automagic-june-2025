resource "azurerm_public_ip" "vwan_lb_public_ip" {
  name                = "waf-vwan-lb-${var.vm_name}-pip"
  location            = azurerm_resource_group.linux.location
  resource_group_name = azurerm_resource_group.linux.name
  allocation_method   = "Static"


  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}