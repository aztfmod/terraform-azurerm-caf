#Reference: https://www.terraform.io/docs/providers/azurerm/r/firewall.html

resource "azurecaf_name" "fw" {
  name          = var.name
  resource_type = "azurerm_firewall"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_firewall" "fw" {

  dns_servers         = try(var.settings.dns_servers, null)
  firewall_policy_id  = var.firewall_policy_id
  location            = var.location
  name                = azurecaf_name.fw.result
  private_ip_ranges   = try(var.settings.private_ip_ranges, null)
  resource_group_name = var.resource_group_name
  sku_name            = try(var.settings.sku_name, "AZFW_VNet")
  sku_tier            = try(var.settings.sku_tier, "Standard")
  tags                = local.tags
  threat_intel_mode   = try(var.settings.virtual_hub, null) != null ? "" : try(var.settings.threat_intel_mode, "Alert")
  zones               = try(var.settings.zones, null)

  ## direct subnet_id reference
  dynamic "ip_configuration" {
    for_each = try([var.settings.public_ip_id], {})

    content {
      name                 = "public-ip"
      public_ip_address_id = ip_configuration.value.public_ip_id
      subnet_id            = var.subnet_id
    }
  }

  ## backward compat with published structures
  dynamic "ip_configuration" {
    for_each = try([var.settings.public_ip_key], {})

    content {
      name                 = ip_configuration.key
      public_ip_address_id = var.public_ip_addresses[var.client_config.landingzone_key][ip_configuration.value].id
      subnet_id            = try(var.subnet_id, null)
    }
  }
  ## backward compat with published structures
  dynamic "ip_configuration" {
    for_each = try(var.settings.public_ip_keys, {})

    content {
      name                 = ip_configuration.key
      public_ip_address_id = var.public_ip_addresses[var.client_config.landingzone_key][ip_configuration.value].id
      subnet_id            = ip_configuration.key == 0 ? var.subnet_id : null
    }
  }
  ## new configuration structure for public_ips
  dynamic "ip_configuration" {
    for_each = try(var.settings.public_ips, {})

    content {
      name                 = ip_configuration.value.name
      public_ip_address_id = can(ip_configuration.value.public_ip_id) ? ip_configuration.value.public_ip_id : var.public_ip_addresses[try(ip_configuration.value.lz_key, var.client_config.landingzone_key)][ip_configuration.value.public_ip_key].id
      subnet_id            = try(ip_configuration.value.subnet_id, null) != null ? ip_configuration.value.subnet_id : (lookup(ip_configuration.value, "lz_key", null) == null ? var.virtual_networks[var.client_config.landingzone_key][ip_configuration.value.vnet_key].subnets[ip_configuration.value.subnet_key].id : var.virtual_networks[ip_configuration.value.lz_key][ip_configuration.value.vnet_key].subnets[ip_configuration.value.subnet_key].id)
    }
  }

  dynamic "management_ip_configuration" {
    for_each = try(var.settings.management_ip_configuration, {})
    content {
      name                 = management_ip_configuration.value.name
      public_ip_address_id = try(management_ip_configuration.value.public_ip_address_id, null) != null ? management_ip_configuration.value.public_ip_address_id : var.public_ip_addresses[try(management_ip_configuration.value.lz_key, var.client_config.landingzone_key)][management_ip_configuration.value.public_ip_key].id
      subnet_id            = try(management_ip_configuration.value.subnet_id, null) != null ? management_ip_configuration.value.subnet_id : (lookup(management_ip_configuration.value, "lz_key", null) == null ? var.virtual_networks[var.client_config.landingzone_key][management_ip_configuration.value.vnet_key].subnets[management_ip_configuration.value.subnet_key].id : var.virtual_networks[management_ip_configuration.value.lz_key][management_ip_configuration.value.vnet_key].subnets[management_ip_configuration.value.subnet_key].id)
    }
  }

  dynamic "virtual_hub" {
    for_each = {
      for key, value in try(var.settings.virtual_hub, {}) : key => value
      if can(value.virtual_wan_key) == false
    }

    content {
      virtual_hub_id = can(virtual_hub.value.virtual_hub_id) || can(virtual_hub.value.virtual_hub.id) ? try(virtual_hub.value.virtual_hub_id, virtual_hub.value.virtual_hub.id) : var.virtual_hubs[try(virtual_hub.value.lz_key, virtual_hub.value.virtual_hub.lz_key, var.client_config.landingzone_key)][try(virtual_hub.value.virtual_hub.key, virtual_hub.value.virtual_hub_key, virtual_hub.value.key)].id

      public_ip_count = try(virtual_hub.value.public_ip_count, 1)
    }
  }

  dynamic "virtual_hub" {
    for_each = {
      for key, value in try(var.settings.virtual_hub, {}) : key => value
      if can(value.virtual_wan_key)
    }

    content {
      virtual_hub_id = can(var.virtual_hubs[try(virtual_hub.value.lz_key, virtual_hub.value.virtual_hub.lz_key, var.client_config.landingzone_key)][try(virtual_hub.value.virtual_hub.key, virtual_hub.value.virtual_hub_key, virtual_hub.value.key)].id) ? var.virtual_hubs[try(virtual_hub.value.lz_key, virtual_hub.value.virtual_hub.lz_key, var.client_config.landingzone_key)][try(virtual_hub.value.virtual_hub.key, virtual_hub.value.virtual_hub_key, virtual_hub.value.key)].id : var.virtual_wans[try(virtual_hub.value.lz_key, var.client_config.landingzone_key)][virtual_hub.value.virtual_wan_key].virtual_hubs[virtual_hub.value.virtual_hub_key].id

      public_ip_count = try(virtual_hub.value.public_ip_count, 1)
    }
  }
}
