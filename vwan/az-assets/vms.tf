# 1. List VMs in the subscription or resource group
# /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/providers/Microsoft.Compute/virtualMachines?api-version=2024-11-01 
data "azapi_resource_list" "vms" {
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}"
  type                   = "Microsoft.Compute/virtualMachines@2024-11-01"  # or latest supported version

}

# 2. For each VM, use a local that extracts all NIC IDs
locals {
  vm_nic_ids = {
    for vm in data.azapi_resource_list.vms.output.value :
    vm.id => {
        vm_id = vm.id
        nic_ids   = [for nic in vm.properties.networkProfile.networkInterfaces : nic.id]
        vm_tags = vm.tags
    }
  }
}

# 3. Fetch details for each NIC using azurerm provider
data "azurerm_network_interface" "by_nic" {
  for_each              = { for key, entry in local.vm_nic_ids : entry.vm_id => entry }
  name                  = element(split("/", each.value.nic_ids[0]), -1)
resource_group_name = element(
    split("/", each.value.nic_ids[0]),
    index(split("/", each.value.nic_ids[0]), "resourceGroups") + 1
)
}

# fetch VMs with azurerm to have vm tags
# data "azurerm_virtual_machine" "by_vm" {
#   for_each              = { for key, entry in local.vm_nic_ids : entry.vm_id => entry }
#   name                  = element(split("/", each.value.vm_id), -1)
#   resource_group_name   = element(
#     split("/", each.value.vm_id),
#     index(split("/", each.value.vm_id), "resourceGroups") + 1
#   )
# }

# 4. You can output the subnet IDs (and hence infer the VNet)

locals {
    vm_subnet_ids =  { for vm_id, entry in data.azurerm_network_interface.by_nic :
            vm_id => entry.ip_configuration[0].subnet_id // /subscriptions/f4ad5e85-ec75-4321-8854-ed7eb611f61d/resourceGroups/vnet_rg77/providers/Microsoft.Network/virtualNetworks/myVNet77/subnets/subnet1"
        }
        // map subnetid to vnet name and rg
    vm_vnet = { for vm_id, entry in local.vm_subnet_ids:
        vm_id => {
            subnet_id = entry
    
            // vnet_id is element without last 2 entries (subnet/subnetname)
            vnet_id = join("/", slice(split("/", entry), 0, length(split("/", entry)) - 2))
            
            rg = element(split("/", entry), 4)
            vnet_name = element(split("/", entry), 8)

            vm_name = element(split("/", vm_id), -1)
            vm_rg = element(split("/", vm_id), 4)

            tags = local.vm_nic_ids[vm_id].vm_tags

        }
    }
}

# output "vm_subnet_ids" {
#   value = { for vm_id, entry in data.azurerm_network_interface.by_nic :
#             vm_id => entry.ip_configuration[0].subnet_id }
# }

resource "local_file" "vms_debug" {
  content = jsonencode({
    # root = "/subscriptions/${data.azapi_client_config.current.subscription_id}"
    # vms = data.azapi_resource_list.vms.output
    vm_nic_ids = local.vm_nic_ids

    # nics = data.azurerm_network_interface.by_nic
    // vm_subnet_ids = local.vm_subnet_ids
    vm_vnet = local.vm_vnet

    # vms = data.azurerm_virtual_machine.by_vm
  })
  filename = "/tmp/vms.json"
}

