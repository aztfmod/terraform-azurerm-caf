resource "azurecaf_name" "vwan" {
  name          = var.settings.name
  resource_type = "azurerm_virtual_wan"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_virtual_wan" "vwan" {

  name                = azurecaf_name.vwan.result
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = local.tags

  type                              = try(var.settings.type, "Standard")
  disable_vpn_encryption            = try(var.settings.disable_vpn_encryption, false)
  allow_branch_to_branch_traffic    = try(var.settings.allow_branch_to_branch_traffic, true)
  office365_local_breakout_category = try(var.settings.office365_local_breakout_category, "None")
}

module hubs {
  source = "./virtual_hub"

  for_each = try(var.settings.hubs, {})

  global_settings     = var.global_settings
  location            = var.global_settings.regions[each.value.region]
  virtual_hub_config  = each.value
  resource_group_name = var.resource_group_name
  vwan_id             = azurerm_virtual_wan.vwan.id
  tags                = merge(try(each.value.tags, null), local.tags)
}

output virtual_hubs {
  value       = module.hubs
  sensitive   = false
  description = "Virtual Hubs object"
}

output virtual_wan {
  value       = azurerm_virtual_wan.vwan
  sensitive   = false
  description = "Virtual WAN object"
}

