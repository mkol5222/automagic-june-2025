
provider "azurerm" {
  subscription_id = local.secrets.subscriptionId
  features {}
}