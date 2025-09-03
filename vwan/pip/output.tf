
output "pip" {
    description = "Public IP for vWAN Load Balancer"
    # pair name ip_address
    value = [for ipid in var.pip_names: ipid => azurerm_public_ip.vwan_lb_public_ip[ipid].ip_address]
}