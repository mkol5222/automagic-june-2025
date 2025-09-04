module "waf" {
  source              = "./waf"
  

    # AppSec(WAF) gateway, Azure profile cp token
    waf_agent_token = local.waf_token

    linux_location = "North Europe"
    linux_rg_name = "automagic-waf-vwan"
    subnet_id="/subscriptions/${local.secrets.subscriptionId}/resourceGroups/automagic-vnet_rg77/providers/Microsoft.Network/virtualNetworks/myVNet77/subnets/subnet1"
    vm_name="automagic-waf-vwan-waf77"
    vnet_cidr="10.77.0.0/16"

}

locals {
    waf_token = (file("${path.module}/../../secrets/waftoken.txt"))
}