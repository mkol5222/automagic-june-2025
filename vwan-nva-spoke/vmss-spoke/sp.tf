# used to retrive credentials from JSON in secrets folder

locals {
  secrets = jsondecode(file("${path.module}/../../secrets/sp.json"))
}

# output "secrets" {
#   value = local.secrets
# }