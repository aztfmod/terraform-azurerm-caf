resource "azurecaf_name" "polgroup" {
  name          = var.policy_settings.name
  resource_type = "azurerm_firewall_network_rule_collection"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "application_rule" {
  for_each = try(var.policy_settings.application_rule_collections, {})

  name          = each.value.name
  resource_type = "azurerm_firewall_application_rule_collection"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "network_rule" {
  for_each = try(var.policy_settings.network_rule_collections, {})

  name          = each.value.name
  resource_type = "azurerm_firewall_network_rule_collection"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "nat_rule" {
  for_each = try(var.policy_settings.nat_rule_collections, {})

  name          = each.value.name
  resource_type = "azurerm_firewall_nat_rule_collection"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


resource "azurerm_firewall_policy_rule_collection_group" "polgroup" {
  name               = azurecaf_name.polgroup.result
  priority           = var.policy_settings.priority
  firewall_policy_id = var.firewall_policy_id

  dynamic "application_rule_collection" {
    for_each = try(var.policy_settings.application_rule_collections, {})

    content {
      name     = azurecaf_name.application_rule[application_rule_collection.key].result
      priority = application_rule_collection.value.priority
      action   = application_rule_collection.value.action

      dynamic "rule" {
        for_each = try(application_rule_collection.value.rules, {})

        content {
          name             = rule.value.name
          source_addresses = try(rule.value.source_addresses, null)
          source_ip_groups = try(rule.value.source_ip_groups, try(flatten([
            for key, value in var.ip_groups : value.id
            if contains(rule.value.source_ip_groups_keys, key)
            ]), null)
          )
          destination_fqdn_tags = try(rule.value.destination_fqdn_tags, null)
          destination_fqdns     = try(rule.value.destination_fqdns, null)

          dynamic "protocols" {
            for_each = try(rule.value.protocols, {})

            content {
              type = protocols.value.type
              port = try(protocols.value.port, null)
            }
          }
        }
      }
    }
  }

  dynamic "network_rule_collection" {
    for_each = try(var.policy_settings.network_rule_collections, {})

    content {
      name     = azurecaf_name.network_rule[network_rule_collection.key].result
      priority = network_rule_collection.value.priority
      action   = network_rule_collection.value.action

      dynamic "rule" {
        for_each = try(network_rule_collection.value.rules, {})

        content {
          name             = rule.value.name
          source_addresses = try(rule.value.source_addresses, null)
          source_ip_groups = try(rule.value.source_ip_groups, try(flatten([
            for key, value in var.ip_groups : value.id
            if contains(rule.value.source_ip_groups_keys, key)
            ]), null)
          )
          destination_addresses = try(rule.value.destination_addresses, null)
          destination_fqdns     = try(rule.value.destination_fqdns, null)
          destination_ip_groups = try(rule.value.destination_ip_groups, try(flatten([
            for key, value in var.ip_groups : value.id
            if contains(rule.value.destination_ip_groups_keys, key)
            ]), null)
          )
          destination_ports = rule.value.destination_ports
          protocols         = rule.value.protocols
        }
      }
    }
  }

  dynamic "nat_rule_collection" {
    for_each = try(var.policy_settings.nat_rule_collections, {})

    content {
      name     = azurecaf_name.nat_rule[nat_rule_collection.key].result
      priority = nat_rule_collection.value.priority
      action   = nat_rule_collection.value.action

      dynamic "rule" {
        for_each = try(nat_rule_collection.value.rules, {})

        content {
          name             = rule.value.name
          source_addresses = try(rule.value.source_addresses, null)
          source_ip_groups = try(rule.value.source_ip_groups, try(flatten([
            for key, value in var.ip_groups : value.id
            if contains(rule.value.source_ip_groups_keys, key)
            ]), null)
          )
          destination_ports = try(rule.value.destination_ports, null)
          destination_address = try(
            rule.value.destination_address,
            var.public_ip_addresses[rule.value.destination_address_public_ip_key].ip_address
          )
          translated_port    = rule.value.translated_port
          translated_address = rule.value.translated_address
          protocols          = rule.value.protocols
        }
      }
    }
  }


}

