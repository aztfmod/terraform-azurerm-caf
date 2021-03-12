#Core outputs

output objects {
  value     = tomap({ (var.landingzone.key) = module.solution })
  sensitive = true
}

output tfstates {
  value     = local.tfstates
  sensitive = true
}
