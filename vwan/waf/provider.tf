terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.42.0"
    }
  }
}

provider "azurerm" {
  subscription_id = local.sp.subscriptionId
  features {}
}