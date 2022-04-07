resource "azurecaf_name" "rule" {
  for_each = toset(var.rule_collections)

  name          = var.azurerm_firewall_application_rule_collection_definition[each.key].name
  resource_type = "azurerm_firewall_application_rule_collection"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_firewall_application_rule_collection" "rule" {
  for_each = toset(var.rule_collections)

  name                = azurecaf_name.rule[each.key].result
  azure_firewall_name = var.azure_firewall_name
  resource_group_name = var.resource_group_name
  priority            = var.azurerm_firewall_application_rule_collection_definition[each.key].priority
  action              = var.azurerm_firewall_application_rule_collection_definition[each.key].action

  dynamic "rule" {
    for_each = var.azurerm_firewall_application_rule_collection_definition[each.key].ruleset

    content {
      name             = rule.value.name
      description      = try(rule.value.description, null)
      source_addresses = try(rule.value.source_addresses, null)
      source_ip_groups = try(rule.value.source_ip_groups, try(flatten([
        for key, value in var.ip_groups : value.id
        if contains(rule.value.source_ip_groups_keys, key)
        ]), null)
      )
      fqdn_tags    = try(rule.value.fqdn_tags, null)
      target_fqdns = try(rule.value.target_fqdns, null)

      dynamic "protocol" {
        for_each = try(rule.value.protocol, {})

        content {
          type = protocol.value.type
          port = try(protocol.value.port, null)
        }
      }
    }
  }
}
