# # /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/automagic-vwan-ffeb4275/providers/Microsoft.Network/virtualHubs/am-vwan-hub

# data "azurerm_virtual_hub" "vwan_hub" {
#   name                = var.vwan_hub_name
#   resource_group_name = var.vwan_hub_rg
# }


# /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/automagic-vwan-ffeb4275/providers/Microsoft.Network/virtualHubs/am-vwan-hub

# current azure subscription
data "azurerm_subscription" "current" {}

output "subscription_id" {
  value = data.azurerm_subscription.current.id
}

locals  {
  hub_id = "${data.azurerm_subscription.current.id}/resourceGroups/${var.vwan_hub_rg}/providers/Microsoft.Network/virtualHubs/${var.vwan_hub_name}"
}

output "hub_id" {
  value = local.hub_id
}