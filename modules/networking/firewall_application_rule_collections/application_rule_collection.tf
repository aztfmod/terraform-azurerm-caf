resource "azurerm_firewall_application_rule_collection" "rule" {
  for_each = toset(var.rule_collections)

  name                = var.azurerm_firewall_application_rule_collection_definition[each.key].name
  azure_firewall_name = var.azure_firewall_name
  resource_group_name = var.resource_group_name
  priority            = var.azurerm_firewall_application_rule_collection_definition[each.key].priority
  action              = var.azurerm_firewall_application_rule_collection_definition[each.key].action

  dynamic "rule" {
    for_each = var.azurerm_firewall_application_rule_collection_definition[each.key].ruleset

    content {
      name             = rule.value.name
      description      = try(rule.value.description, null)
      source_addresses = rule.value.source_addresses
      fqdn_tags        = try(rule.value.fqdn_tags, null)
      target_fqdns     = try(rule.value.target_fqdns, null)

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