

module "linux77" {
    source = "./linux"
    subnet_id = module.spoke77.subnet_id
    vm_name = "linux77"
    # vm_size = "Standard_DS1_v2"
    linux_rg_name = "automagic-linux77-rg"
    linux_location = "North Europe"
}



module "linux68" {
    source = "./linux"
    subnet_id = module.spoke68.subnet_id
    vm_name = "linux68"
    # vm_size = "Standard_DS1_v2"
    linux_rg_name = "automagic-linux68-rg"
    linux_location = "North Europe"
}

# module "linux69" {
#     source = "./linux"
#     subnet_id = module.spoke69.subnet_id
#     vm_name = "linux69"
#     # vm_size = "Standard_DS1_v2"
#     linux_rg_name = "automagic-linux69-rg"
#     linux_location = "North Europe"
# }

# resource "azurerm_public_ip" "linux69lbpip" {
#   name                = "linux69lbpip"
#   location            = "North Europe"
#   resource_group_name = "automagic-linux69-rg"
#   allocation_method   = "Static"
#   sku                 = "Standard"

#   lifecycle {
#     ignore_changes = [
#       # Ignore changes to tags, e.g. because a management agent
#       # updates these based on some ruleset managed elsewhere.
#       tags,
#     ]
#   }
# }