locals {
  secrets = jsondecode(file("${path.module}/../secrets/sp.json"))
}
