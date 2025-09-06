// random sic_key 
# resource "random_password" "sic_key" {
#   length  = 18
#   special = false
#   upper   = true
#   lower   = true
#   numeric  = true
#   # override_special = "!@#$%^&*()_+"
#   keepers = {
#     envId = local.secrets.envId
#   }
# }