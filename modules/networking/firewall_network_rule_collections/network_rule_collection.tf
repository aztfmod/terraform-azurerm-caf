resource "azurerm_firewall_network_rule_collection" "rule" {
  for_each = toset(var.rule_collections)

  name                = var.azurerm_firewall_network_rule_collection_definition[each.key].name
  azure_firewall_name = var.azure_firewall_name
  resource_group_name = var.resource_group_name
  priority            = var.azurerm_firewall_network_rule_collection_definition[each.key].priority
  action              = var.azurerm_firewall_network_rule_collection_definition[each.key].action

  dynamic "rule" {
    for_each = var.azurerm_firewall_network_rule_collection_definition[each.key].ruleset

    content {
      name                  = rule.value.name
      description           = try(rule.value.description, null)
      source_addresses      = rule.value.source_addresses
      destination_addresses = rule.value.destination_addresses
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
    }
  }
}