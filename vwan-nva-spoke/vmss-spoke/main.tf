provider "azurerm" {
  features {}
}

module "vmss_new_vnet" {

   # depends_on = [random_password.admin_password, random_password.sic_key]

    source  = "CheckPointSW/cloudguard-network-security/azure//modules/vmss_new_vnet"
    version = "1.0.4"

    subscription_id                 = local.secrets.subscriptionId
    source_image_vhd_uri            = "noCustomUri"
    resource_group_name             = "automagic-vwan-vmss-spoke-${local.secrets.envId}"
    location                        =  "northeurope"
    vmss_name                       = "vmss-spoke-${local.secrets.envId}"
    vnet_name                       = "vmss-spoke-vnet"
    address_space                   = "10.208.0.0/16"
    subnet_prefixes                 = ["10.208.1.0/24","10.208.2.0/24"]
    backend_lb_IP_address           = 4
    admin_password                  = var.admin_password != null ? var.admin_password : random_password.admin_password.result
    sic_key                         = var.sic_key  #random_password.sic_key.result
    vm_size                         = "Standard_D3_v2"
    disk_size                       = "100"
    vm_os_sku                       = "sg-byol"
    vm_os_offer                     = "check-point-cg-r8120"
    os_version                      = "R8120"
    bootstrap_script                = "touch /home/admin/bootstrap.txt; echo 'hello_world' > /home/admin/bootstrap.txt"
    allow_upload_download           = true
    authentication_type             = "Password"
    availability_zones_num          = "1"
    minimum_number_of_vm_instances  = 2
    maximum_number_of_vm_instances  = 10
    management_name                 = "mgmt"
    management_IP                   = var.management_IP
    management_interface            = "eth0-public"
    configuration_template_name     = "vmss_template"
    notification_email              = ""
    frontend_load_distribution      = "Default"
    backend_load_distribution       = "Default"
    enable_custom_metrics           = true
    enable_floating_ip              = false
    deployment_mode                 = "Standard"
    admin_shell                     = "/bin/bash"
    serial_console_password_hash    = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    maintenance_mode_password_hash  = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    nsg_id                          = ""
    add_storage_account_ip_rules    = false
    storage_account_additional_ips  = []
}