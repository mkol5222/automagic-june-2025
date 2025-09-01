locals {
  sp = jsondecode(file("${path.module}/../../secrets/sp.json"))
}
