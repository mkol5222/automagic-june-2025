resource "azurerm_public_ip" "vwan_lb_public_ip" {
    for_each = toset(var.pip_names)
  name                = each.key
  location            = var.vwan_location
  resource_group_name = local.vwan_rg
  allocation_method   = "Static"
  sku                 = "Standard"


  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}