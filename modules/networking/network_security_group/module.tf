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
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = local.tags

  dynamic "security_rule" {
    for_each = try(var.settings.nsg, [])
    content {
      name                         = try(security_rule.value.name, null)
      priority                     = try(security_rule.value.priority, null)
      direction                    = try(security_rule.value.direction, null)
      access                       = try(security_rule.value.access, null)
      protocol                     = try(security_rule.value.protocol, null)
      source_port_range            = try(security_rule.value.source_port_range, null)
      source_port_ranges           = try(security_rule.value.source_port_ranges, null)
      destination_port_range       = try(security_rule.value.destination_port_range, null)
      destination_port_ranges      = try(security_rule.value.destination_port_ranges, null)
      source_address_prefix        = try(security_rule.value.source_address_prefix, null)
      source_address_prefixes      = try(security_rule.value.source_address_prefixes, null)
      destination_address_prefix   = try(security_rule.value.destination_address_prefix, null)
      destination_address_prefixes = try(security_rule.value.destination_address_prefixes, null)
      # source_application_security_group_ids      = try(security_rule.value.source_application_security_group_ids, null)
      # destination_application_security_group_ids = try(security_rule.value.destination_application_security_group_ids, null)


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

output "id" {
  value = azurerm_network_security_group.nsg.id
}