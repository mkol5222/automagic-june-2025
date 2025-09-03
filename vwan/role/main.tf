
data "azuread_client_config" "current" {}

resource "azuread_application" "vwan_role" {
  display_name = "automagic-vwan-cme-role-${var.envId}"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "vwan_role-key" {
  display_name          = "automagic-vwan-cme-role-${var.envId}-password"
  end_date_relative     = "8640h" # one-year time frame
  application_object_id = azuread_application.vwan_role.object_id
}

resource "azuread_service_principal" "vwan_role-sp" {
  client_id = azuread_application.vwan_role.application_id
  //application_id = azuread_application.vwan_role.object_id
  owners = [data.azuread_client_config.current.object_id]
}


resource "azurerm_role_assignment" "vwan_role-role-assign" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.vwan_role-sp.object_id
}

resource "azurerm_role_assignment" "vwan_role-role-assign2" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.nva-rg}"
  role_definition_name = "Network Contributor"
  principal_id         = azuread_service_principal.vwan_role-sp.object_id
}


# CME account with service principle that has:

#     Reader and Network Contributor roles for the NVA's managed resource group.

#     Reader role for relevant public IP addresses (or their resource group).

