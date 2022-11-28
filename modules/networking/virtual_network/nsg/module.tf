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

  security_rule = can(var.network_security_group_definition[each.value.nsg_key].nsg) == false ? [] : [
    for value in var.network_security_group_definition[each.value.nsg_key].nsg : {
      name                         = value.name
      description                  = lookup(value, "description", "")
      priority                     = value.priority
      direction                    = value.direction
      access                       = value.access
      protocol                     = value.protocol
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
  ]
}
