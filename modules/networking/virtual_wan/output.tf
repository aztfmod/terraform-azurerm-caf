output "virtual_hubs" {
  value = module.hubs

  description = "Virtual Hubs object"
}

output "virtual_wan" {
  value = azurerm_virtual_wan.vwan

  description = "Virtual WAN object"
}
