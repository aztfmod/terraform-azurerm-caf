# processing of the rules for:
# azurerm_firewall_nat_rule_collection - https://www.terraform.io/docs/providers/azurerm/r/firewall_nat_rule_collection.html

resource "azurecaf_name" "natcollection" {
  for_each = toset(var.rule_collections)

  name          = var.azurerm_firewall_nat_rule_collection_definition[each.key].name
  resource_type = "azurerm_firewall_nat_rule_collection"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_firewall_nat_rule_collection" "natcollection" {
  for_each = toset(var.rule_collections)

  name                = azurecaf_name.natcollection[each.key].result
  azure_firewall_name = var.azure_firewall_name
  resource_group_name = var.resource_group_name
  priority            = var.azurerm_firewall_nat_rule_collection_definition[each.key].priority
  action              = var.azurerm_firewall_nat_rule_collection_definition[each.key].action

  dynamic "rule" {
    for_each = var.azurerm_firewall_nat_rule_collection_definition[each.key].ruleset
    content {
      name             = rule.value.name
      description      = try(rule.value.description, null)
      source_addresses = try(rule.value.source_addresses, null)
      source_ip_groups = try(rule.value.source_ip_groups, try(flatten([
        for key, value in var.ip_groups : value.id
        if contains(rule.value.source_ip_groups_keys, key)
        ]), null)
      )
      destination_ports = rule.value.destination_ports
      destination_addresses = try(rule.value.destination_addresses, try(flatten([
        for key, value in var.public_ip_addresses : value.ip_address
        if contains(rule.value.destination_addresses_public_ips_keys, key)
        ]), null)
      )
      translated_port    = rule.value.translated_port
      translated_address = rule.value.translated_address
      protocols          = rule.value.protocols
    }
  }
}
