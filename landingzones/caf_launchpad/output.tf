
output objects {
  value     = tomap({ (var.landingzone.key) = module.launchpad })
  sensitive = true
}

output tfstates {
  value     = local.tfstates
  sensitive = true
}
