output "subnet_id" {
  value       = azurerm_subnet.spoke_subnet.id
  description = "The ID of the subnet"
}