output "sic_key" {
  value = var.sic_key #random_password.sic_key.result
  sensitive = true
}

output "admin_password" {
  value = random_password.admin_password.result
  sensitive = true
}