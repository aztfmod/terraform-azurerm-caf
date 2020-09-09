output azurerm_firewalls {
  value     = module.landingzones_networking.azurerm_firewalls
  sensitive = true
}

output vnets {
  value     = local.vnets
  sensitive = false
}

output tfstates {
  value     = local.tfstates
  sensitive = false
}

output virtual_wans {
  value       = module.landingzones_networking.virtual_wans
  sensitive   = false
  description = "Virtual WAN output"
  depends_on  = []
}