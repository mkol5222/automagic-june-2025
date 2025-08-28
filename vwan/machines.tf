

module "linuxA" {
    source = "./linux"
    subnet_id = module.spoke77.subnet_id
    vm_name = "linuxA"
    # vm_size = "Standard_DS1_v2"
    linux_rg_name = "linuxA-rg"
    linux_location = "North Europe"
}