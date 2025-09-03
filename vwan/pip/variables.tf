variable "pip_names" {
  description = "List of Public IP names"
  type        = list(string)
  default     = ["vwan-lb-a-pip", "vwan-lb-b-pip"]
}

// vwan_rg
# variable "vwan_rg" {
#   description = "The name of the resource group for the VWAN"
#   type        = string
#   default     = "automagic-vwan-${local.secrets.envId}"
# }
locals {
  vwan_rg = "automagic-vwan-${local.secrets.envId}"
}



// vwan_location
variable "vwan_location" {
  description = "The location of the VWAN"
  type        = string
  default     = "North Europe"
}