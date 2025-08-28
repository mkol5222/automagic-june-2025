
variable "vnet_address" {
    description = "The address space for the virtual network"
    type        = string
    # default     = "10.0.0.0/16"
}

variable "vnet_name" {
    description = "The name of the virtual network"
    type        = string
    # default     = "myVNet"
}

variable "vnet_rg" {
    description = "The resource group of the virtual network"
    type        = string
    # default     = "myVNetRG"
}




variable "vwan_hub_rg" {
    description = "The resource group of the virtual network hub"
    type        = string
    # default     = "myVNetHubRG"
}

variable "vwan_hub_name" {
    description = "The name of the virtual network hub"
    type        = string
    # default     = "myVNetHub"
}