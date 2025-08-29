# 1. List VMs in the subscription or resource group
data "azapi_resource_list" "vms" {
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}"
  type                   = "Microsoft.Compute/virtualMachines@2024-11-01"  # or latest supported version
  response_export_values = ["id", "properties"]
}

# 2. For each VM, use a local that extracts all NIC IDs
locals {
  vm_nic_ids = [
    for vm in data.azapi_resource_list.vms.output : 
    {
      vm_id     = vm.id
      nic_ids   = [for nic in vm.properties.networkProfile.networkInterfaces : nic.id]
    }
  ]
}

# 3. Fetch details for each NIC using azurerm provider
data "azurerm_network_interface" "by_nic" {
  for_each              = { for entry in local.vm_nic_ids : entry.vm_id => entry }
  name                  = element(split("/", each.value.nic_ids[0]), -1)
resource_group_name = element(
    split("/", each.value.nic_ids[0]),
    index(split("/", each.value.nic_ids[0]), "resourceGroups") + 1
)
}

# 4. You can output the subnet IDs (and hence infer the VNet)
output "vm_subnet_ids" {
  value = { for vm_id, entry in data.azurerm_network_interface.by_nic :
            vm_id => entry.ip_configuration[0].subnet_id }
}

resource "local_file" "vms_debug" {
  content = jsonencode({
    vms = data.azapi_resource_list.vms.output
    vm_nic_ids = local.vm_nic_ids
  })
  filename = "/tmp/vms.json"
}

