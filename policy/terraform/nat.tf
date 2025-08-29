resource "checkpoint_management_nat_section" "test" {
    name = "vWAN NVA"
    package = "${checkpoint_management_package.vmss.name}"
    #layer       = "${checkpoint_management_package.vmss.name} Network"
    position = {top = "top"}
}

resource "checkpoint_management_nat_rule" "rule100" {
  package = "${checkpoint_management_package.vmss.name}"
  position = {below = checkpoint_management_nat_section.test.id}
  name = "No NAT inside VNET"
  original_source = checkpoint_management_network.vnet_all.id
  original_destination = checkpoint_management_network.vnet_all.id
  original_service = "Any"
#   translated_source = checkpoint_management_network.vnet_dmz.id
#   translated_destination = checkpoint_management_network.vnet_all.id
#   translated_service = checkpoint_management_service.http.id
}

resource "checkpoint_management_nat_rule" "rule110" {
  package = "${checkpoint_management_package.vmss.name}"
  position = {below = checkpoint_management_nat_rule.rule100.id}
  name = "Hide NAT VNET to Internet"
  original_source = checkpoint_management_network.vnet_all.id
  original_destination = "All_Internet"
  original_service = "Any"
  translated_source = checkpoint_management_dynamic_object.LocalGatewayExternal.id
  method = "hide"
}

resource "checkpoint_management_nat_rule" "rule120" {
  package = "${checkpoint_management_package.vmss.name}"
  position = {below = checkpoint_management_nat_rule.rule110.id}
  name = "Incoming NAT for Linux77 web"
  original_source = "All_Internet"
  original_destination = checkpoint_management_host.vwanlbip.id
  original_service = "HTTPS"
  translated_source = checkpoint_management_dynamic_object.LocalGatewayInternal.id
  method = "static"
}
# HIDE NAT Internal Networks Group All Internet Any LocalGatewayExternal Original Original