output vnets {
  value     = module.landingzones_networking.vnets
  sensitive = true
}

output azurerm_firewalls {
  value     = module.landingzones_networking.azurerm_firewalls
  sensitive = true
}

output combined_vnets {
  value     = local.vnets
  sensitive = true
}

output tfstates {
  value     = local.tfstates
  sensitive = false
}