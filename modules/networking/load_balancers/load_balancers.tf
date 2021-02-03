resource "azurecaf_name" "lb_name" {
  name          = var.settings.name
  resource_type = "azurerm_lb"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_lb" "lb" {
  name                = azurecaf_name.lb_name.result
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.settings.sku #Accepted values are Basic and Standard. Defaults to Basic

  dynamic "frontend_ip_configuration" {
    for_each = try(var.settings.frontend_ip_configuration, {})
    content {
      name = frontend_ip_configuration.value.name
      subnet_id = try(var.vnets[var.client_config.landingzone_key][frontend_ip_configuration.value.vnet_key].subnets[frontend_ip_configuration.value.subnet_key].id, null)
      private_ip_address  = try(frontend_ip_configuration.value.private_ip_address, null)
      private_ip_address_allocation = try(frontend_ip_configuration.value.private_ip_address_allocation, null) #Possible values as Dynamic and Static.
      private_ip_address_version  = try(frontend_ip_configuration.value.private_ip_address_version, null)  #Possible values are IPv4 or IPv6.
      public_ip_address_id = lookup(frontend_ip_configuration.value, "public_ip_address_key", null) == null ? null : try(var.public_ip_addresses[var.client_config.landingzone_key][frontend_ip_configuration.value.public_ip_address_key].id, var.public_ip_addresses[frontend_ip_configuration.value.lz_key][frontend_ip_configuration.value.public_ip_address_key].id)
      public_ip_prefix_id = try(frontend_ip_configuration.value.public_ip_prefix_id, null)
      zones = try(frontend_ip_configuration.value.zones, null)  
    }
  }
}