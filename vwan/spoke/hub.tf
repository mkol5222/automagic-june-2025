# /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/automagic-vwan-ffeb4275/providers/Microsoft.Network/virtualHubs/am-vwan-hub

data "azurerm_virtual_hub" "vwan_hub" {
  name                = var.vwan_hub_name
  resource_group_name = var.vwan_hub_rg
}
