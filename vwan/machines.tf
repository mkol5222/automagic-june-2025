

module "linux77" {
    source = "./linux"
    subnet_id = module.spoke77.subnet_id
    vm_name = "linux77"
    # vm_size = "Standard_DS1_v2"
    linux_rg_name = "linux77-rg"
    linux_location = "North Europe"
}



module "linux68" {
    source = "./linux"
    subnet_id = module.spoke68.subnet_id
    vm_name = "linux68"
    # vm_size = "Standard_DS1_v2"
    linux_rg_name = "linux68-rg"
    linux_location = "North Europe"
}