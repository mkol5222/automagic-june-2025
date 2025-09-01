resource "checkpoint_management_network" "vnet_all" {
  name         = "net_vnet_all"
  subnet4      = "10.0.0.0"
  mask_length4 = 8
  tags    = ["MadeByTerraform"]
}

resource "checkpoint_management_network" "net-linux" {
  broadcast    = "allow"
  color        = "red"
  mask_length4 = 24
  name         = "net-linux"
  nat_settings = {
    "auto_rule"   = "true"
    "hide_behind" = "gateway"
    "install_on"  = "All"
    "method"      = "hide"
  }
  subnet4 = "10.114.1.0"
  tags    = ["a","b","MadeByTerraform","z"]
}

# resource "checkpoint_management_network" "vnet77" {
#   name         = "net_vnet77"
#   subnet4      = "10.77.0.0"
#   mask_length4 = 16

#   nat_settings = {
#     "auto_rule"   = "true"
#     "hide_behind" = "gateway"
#     "install_on"  = "All"
#     "method"      = "hide"
#   }

#   tags    = ["MadeByTerraform"]
# }