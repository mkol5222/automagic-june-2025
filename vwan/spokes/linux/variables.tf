
variable "vm_name" {
    description = "The name of the virtual machine"
    type        = string
    # default     = "myVM"
}

variable "vm_size" {
    description = "The size of the virtual machine"
    type        = string
    default     = "Standard_B2s" // ""Standard_DS1_v2""
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