resource "azurecaf_name" "nsg" {
  name          = var.settings.name
  resource_type = "azurerm_network_security_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_network_security_group" "nsg" {
  name                = azurecaf_name.nsg.result
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = merge(local.tags, try(var.settings.tags, {}))

  security_rule = can(var.settings.nsg) == false ? null : [
    for key, value in local.security_rules : value
  ]
}

locals {
  security_rules = {
    for value in try(var.settings.nsg, {}) : format("%s-%s", value.direction, value.priority) => {
      name                         = value.name
      description                  = lookup(value, "description", "")
      priority                     = value.priority
      direction                    = value.direction
      access                       = value.access
      protocol                     = title(value.protocol)
      source_port_range            = lookup(value, "source_port_range", "")
      source_port_ranges           = lookup(value, "source_port_ranges", [])
      destination_port_range       = lookup(value, "destination_port_range", "")
      destination_port_ranges      = lookup(value, "destination_port_ranges", [])
      source_address_prefix        = lookup(value, "source_address_prefix", "")
      source_address_prefixes      = lookup(value, "source_address_prefixes", [])
      destination_address_prefix   = lookup(value, "destination_address_prefix", "")
      destination_address_prefixes = lookup(value, "destination_address_prefixes", [])

      # Example config file:
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
              for key in try(value.source_application_security_groups.keys, []) : [
                var.application_security_groups[try(value.lz_key, var.client_config.landingzone_key)][key].id
              ]
            ]
          ),
          flatten(
            [
              for asg_id in try(value.source_application_security_groups.ids, []) : [
                asg_id
              ]
            ]
          )
        ), //coalescelist
        []
      )

      destination_application_security_group_ids = try(
        coalescelist(
          flatten(
            [
              for key in try(value.destination_application_security_groups.keys, []) : [
                var.application_security_groups[try(value.lz_key, var.client_config.landingzone_key)][key].id
              ]
            ]
          ),
          flatten(
            [
              for asg_id in try(value.destination_application_security_groups.ids, []) : [
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

output "id" {
  value = azurerm_network_security_group.nsg.id
}