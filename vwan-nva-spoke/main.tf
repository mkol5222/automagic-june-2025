#######################################################################
## Create Resource Group
#######################################################################

resource "azurerm_resource_group" "automagic-vwan-spoke-rg" {
  name     = "automagic-vwan-spoke-${local.secrets.envId}"
  location = var.location
  tags = {
    environment = "spoke"
    deployment  = "terraform"
    microhack   = "vwan"
  }
}

resource "azurerm_resource_group" "automagic-vwan-hub-rg" {
  name     = "automagic-vwan-hub-${local.secrets.envId}"
  location = var.location
  tags = {
    environment = "hub"
    deployment  = "terraform"
    microhack   = "vwan"
  }
}