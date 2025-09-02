resource "checkpoint_management_access_section" "vmss_outbound" {
  name     = "VMSS Outbound"
  position = { top = "top" }
  layer    = "${checkpoint_management_package.vmss.name} Network"
}

resource "checkpoint_management_access_rule" "any_internet" {
  name        = "Allow Internet Access"
  layer       = "${checkpoint_management_package.vmss.name} Network"
  position    = { below = checkpoint_management_access_section.vmss_outbound.id }
  source      = [checkpoint_management_network.vnet_all.name]
  destination = ["Any"]
  service     = ["Any"]
  content     = ["Any"]
  time        = ["Any"]
  install_on  = ["Policy Targets"]
  track = {
    type                    = "Log"
    accounting              = false
    alert                   = "none"
    enable_firewall_session = false
    per_connection          = true
    per_session             = false
  }
  action_settings = {}
  custom_fields   = {}
  vpn             = "Any"
  action          = "Accept"
}

resource "checkpoint_management_access_rule" "to_feeds" {
  name        = "Network Feeds"
  layer       = "${checkpoint_management_package.vmss.name} Network"
  position    = { below = checkpoint_management_access_rule.any_internet.id }
  source      = ["Any"]
  destination = [checkpoint_management_network_feed.quiccloud.name, checkpoint_management_network_feed.feedME.name]
  service     = ["Any"]
  content     = ["Any"]
  time        = ["Any"]
  install_on  = ["Policy Targets"]
  track = {
    type                    = "Log"
    accounting              = false
    alert                   = "none"
    enable_firewall_session = false
    per_connection          = true
    per_session             = false
  }
  action_settings = {}
  custom_fields   = {}
  vpn             = "Any"
  action          = "Accept"
}

resource "checkpoint_management_access_rule" "app_linux1_internet" {
  name        = "app=linux1: Allow Azure VMs tagged"
  layer       = "${checkpoint_management_package.vmss.name} Network"
  position    = { above = checkpoint_management_access_rule.any_internet.id }
  source      = [checkpoint_management_data_center_query.appLinux1.id]
  destination = ["Any"]
  service     = ["Any"]
  content     = ["Any"]
  time        = ["Any"]
  install_on  = ["Policy Targets"]
  track = {
    type                    = "Log"
    accounting              = false
    alert                   = "none"
    enable_firewall_session = false
    per_connection          = true
    per_session             = false
  }
  action_settings = {}
  custom_fields   = {}
  vpn             = "Any"
  action          = "Accept"
}

resource "checkpoint_management_access_section" "e_w" {
  name     = "East-West: VNET to VNET (spoke to spoke)"
  position = { above = checkpoint_management_access_section.vmss_outbound.id }
  layer    = "${checkpoint_management_package.vmss.name} Network"
}

resource "checkpoint_management_access_rule" "vnet68to77" {
  name        = "VNET 68 to 77"
  layer       = "${checkpoint_management_package.vmss.name} Network"
  position    = { below = checkpoint_management_access_section.e_w.id }
  source      = [checkpoint_management_network.spoke68.name]
  destination = [checkpoint_management_network.spoke77.name]
  service     = ["Any"]
  content     = ["Any"]
  time        = ["Any"]
  install_on  = ["Policy Targets"]
  track = {
    type                    = "Log"
    accounting              = false
    alert                   = "none"
    enable_firewall_session = false
    per_connection          = true
    per_session             = false
  }
  action_settings = {}
  custom_fields   = {}
  vpn             = "Any"
  action          = "Accept"
}

resource "checkpoint_management_access_rule" "vnet77to68" {
  name        = "VNET 77 to 68"
  layer       = "${checkpoint_management_package.vmss.name} Network"
  position    = { below = checkpoint_management_access_section.e_w.id }
  source      = [checkpoint_management_network.spoke77.name]
  destination = [checkpoint_management_network.spoke68.name]
  service     = ["Any"]
  content     = ["Any"]
  time        = ["Any"]
  install_on  = ["Policy Targets"]
  track = {
    type                    = "Log"
    accounting              = false
    alert                   = "none"
    enable_firewall_session = false
    per_connection          = true
    per_session             = false
  }
  action_settings = {}
  custom_fields   = {}
  vpn             = "Any"
  action          = "Accept"
}

resource "checkpoint_management_access_section" "vmss_inbound" {
  name     = "VMSS Inbound"
  position = { top = "top" }
  layer    = "${checkpoint_management_package.vmss.name} Network"
}

resource "checkpoint_management_access_rule" "codespace" {
  name        = "Management from Codespace host"
  layer       = "${checkpoint_management_package.vmss.name} Network"
  position    = { below = checkpoint_management_access_section.vmss_inbound.id }
  source      = [checkpoint_management_host.codespace.name]
  destination = ["Any"]
  service     = ["https", "ssh", "http"]
  content     = ["Any"]
  time        = ["Any"]
  install_on  = ["Policy Targets"]
  track = {
    type                    = "Log"
    accounting              = false
    alert                   = "none"
    enable_firewall_session = false
    per_connection          = true
    per_session             = false
  }
  action_settings = {}
  custom_fields   = {}
  vpn             = "Any"
  action          = "Accept"
}

resource "checkpoint_management_access_rule" "linux69" {
  name        = "linux69 (linux69lbpip) access from Internet"
  layer       = "${checkpoint_management_package.vmss.name} Network"
  position    = { below = checkpoint_management_access_rule.codespace.id }
  source      = ["Any"]
  destination = [checkpoint_management_host.linux69lbpip.id]
  service     = ["https", "http"]
  content     = ["Any"]
  time        = ["Any"]
  install_on  = ["Policy Targets"]
  track = {
    type                    = "Log"
    accounting              = false
    alert                   = "none"
    enable_firewall_session = false
    per_connection          = true
    per_session             = false
  }
  action_settings = {}
  custom_fields   = {}
  vpn             = "Any"
  action          = "Accept"
}

resource "checkpoint_management_access_rule" "linux77" {
  name        = "linux77 (vwanlbip) access from Internet"
  layer       = "${checkpoint_management_package.vmss.name} Network"
  position    = { below = checkpoint_management_access_rule.codespace.id }
  source      = ["Any"]
  destination = [checkpoint_management_host.vwanlbip.id]
  service     = ["https", "ssh", "http"]
  content     = ["Any"]
  time        = ["Any"]
  install_on  = ["Policy Targets"]
  track = {
    type                    = "Log"
    accounting              = false
    alert                   = "none"
    enable_firewall_session = false
    per_connection          = true
    per_session             = false
  }
  action_settings = {}
  custom_fields   = {}
  vpn             = "Any"
  action          = "Accept"
}

resource "checkpoint_management_access_rule" "wafin" {
  name        = "WAF access from Internet"
  layer       = "${checkpoint_management_package.vmss.name} Network"
  position    = { below = checkpoint_management_access_rule.codespace.id }
  source      = ["Any"]
  destination = [checkpoint_management_host.vwan-waf-lbip.id]
  service     = ["https", "ssh", "http"]
  content     = ["Any"]
  time        = ["Any"]
  install_on  = ["Policy Targets"]
  track = {
    type                    = "Log"
    accounting              = false
    alert                   = "none"
    enable_firewall_session = false
    per_connection          = true
    per_session             = false
  }
  action_settings = {}
  custom_fields   = {}
  vpn             = "Any"
  action          = "Accept"
}