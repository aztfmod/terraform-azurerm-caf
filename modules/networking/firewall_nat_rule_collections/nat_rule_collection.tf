# processing of the rules for:
# azurerm_firewall_nat_rule_collection - https://www.terraform.io/docs/providers/azurerm/r/firewall_nat_rule_collection.html

resource "azurecaf_name" "natcollection" {
  for_each = toset(var.rule_collections)

  name          = var.azurerm_firewall_nat_rule_collection_definition[each.key].name
  resource_type = "azurerm_firewall_nat_rule_collection"
  prefixes      = [var.global_settings.prefix]
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
      name                  = rule.value.name
      description           = try(rule.value.description, null)
      source_addresses      = rule.value.source_addresses
      destination_ports     = rule.value.destination_ports
      destination_addresses = rule.value.destination_addresses
      translated_port       = rule.value.translated_port
      translated_address    = rule.value.translated_address
      protocols             = rule.value.protocols
    }
  }
}