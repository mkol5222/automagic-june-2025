
module "remote" {
  source = "./remote"

  location = local.location
  prefix   = local.prefix
}