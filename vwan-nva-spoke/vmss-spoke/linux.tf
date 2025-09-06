module "linux208" {
    source = "../spokes/linux"
    subnet_id = "/subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/automagic-vwan-vmss-spoke-aa41adff/providers/Microsoft.Network/virtualNetworks/vmss-spoke-vnet/subnets/linux" #module.spoke68.subnet_id
    vm_name = "linux208"
    # vm_size = "Standard_DS1_v2"
    linux_rg_name = "automagic-linux208-rg"
    linux_location = "North Europe"
}
