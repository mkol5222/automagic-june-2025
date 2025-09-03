
# resource "checkpoint_management_access_layer" "layer77in" {
  
#   name              = "layer77in"
#   #access            = true
#   #threat_prevention = false
#   comments          = "Layer for vnet77"
#   tags              = ["MadeByTF", "inventory"]
# }

resource "checkpoint_management_access_layer" "layer77out" {

  name              = "layer77out"
  #access            = true
  #threat_prevention = false
  comments          = "Layer for vnet77"
  tags              = ["MadeByTF", "inventory"]

  
}

# resource "checkpoint_management_access_rule" "layer77_rule_ingress" {

#    layer       = "${checkpoint_management_package.vmss.name} Network"
#   position =  {top = "top"} // {top = "top"} // { above = checkpoint_management_access_rule.from_net_linux.id }
#   // {top = "top"} // { above = checkpoint_management_access_rule.from_net_linux.id }

#   name = "vnet77 ingress"

#   source =["Any"]

#   enabled = true

#   destination        =  [checkpoint_management_network.spoke77.id]
#   destination_negate = false

#   service        = ["Any"]
#   service_negate = false

#   action       = "Apply layer"
#   inline_layer = "${checkpoint_management_access_layer.layer77in.id}"

#   #   action_settings = {
#   #     enable_identity_captive_portal = false
#   #   }

#   track = {
#     accounting              = false
#     alert                   = "none"
#     enable_firewall_session = true
#     per_connection          = true
#     per_session             = true
#     type                    = "Log"
#   }
# }

resource "checkpoint_management_access_rule" "layer77_rule_egress" {

   layer       = "${checkpoint_management_package.vmss.name} Network"
  position =  {top = "top"} // {top = "top"} // { above = checkpoint_management_access_rule.from_net_linux.id }
  // {top = "top"} // { above = checkpoint_management_access_rule.from_net_linux.id }

  name = "vnet77 egress"

  source = [checkpoint_management_network.spoke77.id]

  enabled = true

  destination        =["Any"]
  destination_negate = false

  service        = ["Any"]
  service_negate = false

  action       = "Apply layer"
  inline_layer = "${checkpoint_management_access_layer.layer77out.id}"

  #   action_settings = {
  #     enable_identity_captive_portal = false
  #   }

  track = {
    accounting              = false
    alert                   = "none"
    enable_firewall_session = true
    per_connection          = true
    per_session             = true
    type                    = "Log"
  }
}

// check point host CloudFlare DNS 1.1.1.1
resource "checkpoint_management_host" "cfdns" {
    name = "cfdns"
    ipv4_address = "1.1.1.1"
    color = "orange"
}

// 194.228.41.73 ip.iol.cz
resource "checkpoint_management_host" "ipiolcz" {
    name = "ip.iol.cz"
    ipv4_address = "194.228.41.73"
    color = "blue"
}

resource "checkpoint_management_access_rule" "layer77out100" {

   layer       = "${checkpoint_management_access_layer.layer77out.name}"
  position =  {top = "top"} // {top = "top"} // { above = checkpoint_management_access_rule.from_net_linux.id }
  // {top = "top"} // { above = checkpoint_management_access_rule.from_net_linux.id }

  name = "CloudFlare DNS"

  source = ["Any"]

  enabled = true

  destination        =[checkpoint_management_host.cfdns.id]
  destination_negate = false

  service        = ["DNS","HTTPS","HTTP", "icmp-proto"]
  service_negate = false

  action       = "Accept"


  #   action_settings = {
  #     enable_identity_captive_portal = false
  #   }

  track = {
    accounting              = false
    alert                   = "none"
    enable_firewall_session = true
    per_connection          = true
    per_session             = true
    type                    = "Log"
  }
}

resource "checkpoint_management_access_rule" "layer77out110" {

   layer       = "${checkpoint_management_access_layer.layer77out.name}"
  position =  {above =  checkpoint_management_access_rule.layer77out100.id }
  // {top = "top"} // { above = checkpoint_management_access_rule.from_net_linux.id }

  name = "ip.iol.cz"

  source = ["Any"]

  enabled = true

  destination        =[checkpoint_management_host.ipiolcz.id]
  destination_negate = false

  service        = ["HTTPS","HTTP"]
  service_negate = false

  action       = "Accept"


  #   action_settings = {
  #     enable_identity_captive_portal = false
  #   }

  track = {
    accounting              = false
    alert                   = "none"
    enable_firewall_session = true
    per_connection          = true
    per_session             = true
    type                    = "Log"
  }
}