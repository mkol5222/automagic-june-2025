output "name" {
  value = var.name
}

output "rg" {
  value = var.rg != null ? var.rg : "automagic-management-${local.secrets.envId}"
}

output "password" {
  value     = var.admin_password != null ? var.admin_password : random_password.admin_password.result
  sensitive = true
}