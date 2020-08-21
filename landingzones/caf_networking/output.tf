output vnets {
  value     = module.landingzones_networking.vnets
  sensitive = true
}

output azurerm_firewalls {
  value = module.landingzones_networking.azurerm_firewalls
}