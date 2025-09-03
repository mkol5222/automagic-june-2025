

module "spoke77" {
  source        = "./spoke"
  vnet_address  = "10.77.0.0/16"
  vnet_name     = "myVNet77"
  vnet_rg       = "automagic-vnet_rg77"
  vwan_hub_rg   = "automagic-vwan-${local.secrets.envId}"
  vwan_hub_name = "am-vwan-hub"
  vwan_hub_location = "North Europe"
}

module "spoke68" {
  source              = "./spoke"
  vnet_address        = "10.68.0.0/16"
  vnet_name           = "myVNet68"
  vnet_rg             = "automagic-vnet_rg68"
  vwan_hub_rg        = "automagic-vwan-${local.secrets.envId}"
  vwan_hub_name      = "am-vwan-hub"
    vwan_hub_location = "North Europe"
}

# module "spoke69" {
#   source              = "./spoke"
#   vnet_address        = "10.69.0.0/16"
#   vnet_name           = "myVNet69"
#   vnet_rg             = "automagic-vnet_rg69"
#   vwan_hub_rg        = "automagic-vwan-${local.secrets.envId}"
#   vwan_hub_name      = "am-vwan-hub"
# }