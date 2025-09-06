variable "management_IP" {
  description = "Static IP address for management interface"
  type        = string
}

variable "sic_key" {
  description = "SIC key for the Check Point VMSS"
  type        = string
  sensitive   = true
  default     = null
}

variable "admin_password" {
  description = "Admin password for the Check Point VMSS"
  type        = string
  sensitive   = true
  default     = null
}