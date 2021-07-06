resource "azurecaf_name" "fwpol" {
  name          = var.settings.name
  resource_type = "azurerm_firewall_network_rule_collection"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Add a null_resource to track it the firewall is in FirewallPolicyUpdateNotAllowedWhenUpdatingOrDeleting
# Add var.settings in the trigger

resource "azurerm_firewall_policy" "fwpol" {
  name                = azurecaf_name.fwpol.result
  resource_group_name = local.resource_group_name
  location            = local.location

  sku                      = try(var.settings.sku, null)
  base_policy_id           = var.base_policy_id
  threat_intelligence_mode = try(var.settings.threat_intelligence_mode, "Alert")
  tags                     = local.tags

  dynamic "dns" {
    for_each = try(var.settings.dns, null) == null ? [] : [1]

    content {
      servers       = try(var.settings.dns.servers, null)
      proxy_enabled = try(var.settings.dns.proxy_enabled, false)
    }
  }

  dynamic "threat_intelligence_allowlist" {
    for_each = try(var.settings.threat_intelligence_allowlist, null) == null ? [] : [1]

    content {
      ip_addresses = try(var.settings.threat_intelligence_allowlist.ip_addresses, null)
      fqdns        = try(var.settings.threat_intelligence_allowlist.fqdns, null)
    }
  }
}