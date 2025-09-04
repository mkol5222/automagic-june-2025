resource "checkpoint_management_access_layer" "layer68out" {

  name              = "layer68out"
  #access            = true
  #threat_prevention = false
  comments          = "Layer for vnet68"
  tags              = ["MadeByTF", "inventory"]

  
}

resource "checkpoint_management_access_rule" "layer68_rule_egress" {

   layer       = "vmss Network"
  position =  {top = "top"} // {top = "top"} // { above = checkpoint_management_access_rule.from_net_linux.id }
  // {top = "top"} // { above = checkpoint_management_access_rule.from_net_linux.id }

  name = "vnet68 egress"

  source = ["net_vnet_spoke68"]//[checkpoint_management_network.spoke68.id]

  enabled = true

  destination        =["Any"]
  destination_negate = false

  service        = ["Any"]
  service_negate = false

  action       = "Apply layer"
  inline_layer = "${checkpoint_management_access_layer.layer68out.id}"

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