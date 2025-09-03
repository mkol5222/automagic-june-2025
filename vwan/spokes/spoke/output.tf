output "subnet_id" {
  value       = azurerm_subnet.spoke_subnet.id
  description = "The ID of the subnet"
}

output "vnet_id" {
  value       = azurerm_virtual_network.spoke.id
  description = "The ID of the virtual network"
}

# output "hub_id" {
#   value       = local.hub_id
#   description = "The ID of the virtual hub"
# }