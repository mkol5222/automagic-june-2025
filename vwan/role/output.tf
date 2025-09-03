
output "client_id" {
  value = azuread_application.vwan_role
}

output "client_secret" {
  value = azuread_application_password.vwan_role.value
}

