resource "checkpoint_management_host" "example222" {
  name = "tf-host222"
  ipv4_address = "192.0.222.1"
  color = "blue"
  tags = ["tag1", "tag2", "madeByTf"]
  comments = "This is a new host"
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