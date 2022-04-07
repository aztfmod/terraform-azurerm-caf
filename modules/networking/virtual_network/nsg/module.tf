resource "azurecaf_name" "nsg_obj" {
  for_each = {
    for key, value in var.subnets : key => value
    if try(value.nsg_key, null) != null && try(var.network_security_group_definition[value.nsg_key].version, 0) == 0
  }
  name          = try(var.network_security_group_definition[each.value.nsg_key].name, null) == null ? each.value.name : var.network_security_group_definition[each.value.nsg_key].name
  resource_type = "azurerm_network_security_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_network_security_group" "nsg_obj" {

  for_each = {
    for key, value in var.subnets : key => value
    if try(value.nsg_key, null) != null && try(var.network_security_group_definition[value.nsg_key].version, 0) == 0
  }
  name                = azurecaf_name.nsg_obj[each.key].result
  resource_group_name = var.resource_group
  location            = var.location
  tags                = local.tags

  dynamic "security_rule" {
    for_each = try(var.network_security_group_definition[each.value.nsg_key].nsg, [])
    content {
      name                         = lookup(security_rule.value, "name", null)
      description                  = lookup(security_rule.value, "description", null)
      priority                     = lookup(security_rule.value, "priority", null)
      direction                    = lookup(security_rule.value, "direction", null)
      access                       = lookup(security_rule.value, "access", null)
      protocol                     = lookup(security_rule.value, "protocol", null)
      source_port_range            = lookup(security_rule.value, "source_port_range", null)
      source_port_ranges           = lookup(security_rule.value, "source_port_ranges", null)
      destination_port_range       = lookup(security_rule.value, "destination_port_range", null)
      destination_port_ranges      = lookup(security_rule.value, "destination_port_ranges", null)
      source_address_prefix        = lookup(security_rule.value, "source_address_prefix", null)
      source_address_prefixes      = lookup(security_rule.value, "source_address_prefixes", null)
      destination_address_prefix   = lookup(security_rule.value, "destination_address_prefix", null)
      destination_address_prefixes = lookup(security_rule.value, "destination_address_prefixes", null)

      # source_application_security_groups = {
      #   keys = ["app_server"]
      # }
      # or
      # source_application_security_groups = {
      #   ids = ["resource_id"]
      # }

      source_application_security_group_ids = try(
        coalescelist(
          flatten(
            [
              for key in try(security_rule.value.source_application_security_groups.keys, []) : [
                var.application_security_groups[try(security_rule.value.lz_key, var.client_config.landingzone_key)][key].id
              ]
            ]
          ),
          flatten(
            [
              for asg_id in try(security_rule.value.source_application_security_groups.ids, []) : [
                asg_id
              ]
            ]
          )
        ), //coalescelist
        []
      )


      # destination_application_security_groups = {
      #   keys = ["app_server"]
      # }
      # or
      # destination_application_security_groups = {
      #   ids = ["resource_id"]
      # }

      destination_application_security_group_ids = try(
        coalescelist(
          flatten(
            [
              for key in try(security_rule.value.destination_application_security_groups.keys, []) : [
                var.application_security_groups[try(security_rule.value.lz_key, var.client_config.landingzone_key)][key].id
              ]
            ]
          ),
          flatten(
            [
              for asg_id in try(security_rule.value.destination_application_security_groups.ids, []) : [
                asg_id
              ]
            ]
          )
        ),
        []
      )
    }
  }
}
