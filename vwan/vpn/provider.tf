# terraform {
#   required_providers {
#     checkpoint = {
#       source  = "CheckPointSW/checkpoint"
#       version = "2.10.0"
#     }
#   }
# }

# provider "checkpoint" {
#   # Configuration options

# }

provider "azurerm" {
  subscription_id = local.secrets.subscriptionId
  features {}
}