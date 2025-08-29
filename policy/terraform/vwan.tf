resource "checkpoint_management_host" "vwanlbip" {
  name         = "vwanlbip"
  ipv4_address = "20.166.49.142" # PIP am-vwan-nva-ipIngress
  color        = "red"
  tags        = ["Joking_NotReallyMadeByTerraform"]
  comments     = "vWAN NVAs FrontEnd Load Balancer IP"
}