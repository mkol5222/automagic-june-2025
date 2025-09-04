
locals {
    rulesdata = yamldecode(file("${path.module}/_rules.yaml"))
    rulesmap = { for r in local.rulesdata.rules : r.name => r }
}

output "rulesdata" {
    value = jsonencode(local.rulesdata)
}

resource "checkpoint_management_access_rule" "vnet68egress" {

    for_each = local.rulesmap

  layer       = "${checkpoint_management_access_layer.layer68out.name}"
  position =  {top = "top"} // {top = "top"} // { above = checkpoint_management_access_rule.from_net_linux.id }
  // {top = "top"} // { above = checkpoint_management_access_rule.from_net_linux.id }

  name = each.value.name

  source = each.value.source

  enabled = true

  destination        = each.value.destination
  destination_negate = false

  service        = each.value.service
  service_negate = false

  action       = each.value.action


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