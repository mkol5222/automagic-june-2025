variable "waf_agent_token" {
  type        = string
  description = "The WAF agent token for authentication"
}


variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
  # default     = "myVM"
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
  default     = "Standard_DS2_v2" //"Standard_B2s" // ""Standard_DS1_v2""
}


variable "linux_rg_name" {
  description = "The resource group of the Linux virtual machine"
  type        = string
  # default     = "myLinuxRG"
}

variable "linux_location" {
  description = "The location of the Linux virtual machine"
  type        = string
  # default     = "East US"
}

variable "vnet_cidr" {
  description = "The CIDR block of the virtual network"
  type        = string
#  default     = "10.0.0.0/16"
}