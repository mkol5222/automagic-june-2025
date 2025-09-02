  variable "vwanlbip" {
    description = "vWAN Load Balancer IP"
    type        = string
    default     = "194.228.2.1"
  }

  resource "checkpoint_management_host" "vwanlbip" {
    name         = "vwanlbip"
    ipv4_address = var.vwanlbip
    color        = "red"
    tags        = ["Joking_NotReallyMadeByTerraform"]
    comments     = "vWAN NVAs FrontEnd Load Balancer IP"
  }

# 20.166.17.164 WAF IP on wVAN LB
resource "checkpoint_management_host" "vwan-waf-lbip" {
  name         = "vwan-waf-lbip"
  ipv4_address = "20.166.17.164" # PIP am-vwan-nva-ipIngress
  color        = "red"
  tags        = ["Joking_NotReallyMadeByTerraform"]
  comments     = "vWAN NVAs FrontEnd Load Balancer IP"
}

resource "checkpoint_management_host" "linux69lbpip" {
  name         = "linux69lbpip"
  ipv4_address = "4.210.72.149" # PIP am-vwan-nva-ipIngress
  color        = "red"
  tags        = ["Joking_NotReallyMadeByTerraform"]
  comments     = "Linux69 vWAN NVAs FrontEnd Load Balancer IP"
}

resource "checkpoint_management_host" "linux77" {
  name         = "linux77"
  ipv4_address = "10.77.1.4"
  color        = "blue"

}

resource "checkpoint_management_host" "waf77" {
  name         = "waf77"
  ipv4_address = "10.77.1.5"
  color        = "blue"

}

resource "checkpoint_management_host" "linux68" {
  name         = "linux68"
  ipv4_address = "10.68.1.4"
  color        = "blue"

}

resource "checkpoint_management_host" "linux69" {
  name         = "linux69"
  ipv4_address = "10.69.1.4"
  color        = "blue"
}


resource "checkpoint_management_network" "spoke68" {
  name         = "net_vnet_spoke68"
  subnet4      = "10.68.0.0"
  mask_length4 = 16
  tags    = ["MadeByTerraform"]
}

resource "checkpoint_management_network" "spoke77" {
  name         = "net_vnet_spoke77"
  subnet4      = "10.77.0.0"
  mask_length4 = 16
  tags    = ["MadeByTerraform"]
  ignore_warnings = true
}


resource "checkpoint_management_data_center_query" "appLinux68" {

  depends_on = [checkpoint_management_azure_data_center_server.azureDC]

  name         = "app=linux68"
  data_centers = [checkpoint_management_azure_data_center_server.azureDC.name]
  query_rules {
    key_type = "predefined"
    key      = "type-in-data-center"
    values   = ["Virtual Machine"]
  }
  query_rules {
    key_type = "tag"
    key      = "app"
    values   = ["linux68"]
  }
}

resource "checkpoint_management_data_center_query" "appLinux77" {

  depends_on = [checkpoint_management_azure_data_center_server.azureDC]

  name         = "app=linux77"
  data_centers = [checkpoint_management_azure_data_center_server.azureDC.name]
  query_rules {
    key_type = "predefined"
    key      = "type-in-data-center"
    values   = ["Virtual Machine"]
  }
  query_rules {
    key_type = "tag"
    key      = "app"
    values   = ["linux77"]
  }
}