
resource "azurerm_network_security_rule" "rule" {
  for_each = local.rules

  name                                       = each.value.name
  resource_group_name                        = each.value.resource_group_name
  network_security_group_name                = each.value.network_security_group_name
  description                                = each.value.description
  priority                                   = each.value.priority
  direction                                  = each.value.direction
  access                                     = each.value.access
  protocol                                   = each.value.protocol
  source_port_range                          = each.value.source_port_range
  source_port_ranges                         = each.value.source_port_ranges
  destination_port_range                     = each.value.destination_port_range
  destination_port_ranges                    = each.value.destination_port_ranges
  source_address_prefix                      = each.value.source_address_prefix
  destination_address_prefixes               = each.value.destination_address_prefixes
  destination_address_prefix                 = each.value.destination_address_prefix
  source_application_security_group_ids      = each.value.source_application_security_group_ids
  destination_application_security_group_ids = each.value.destination_application_security_group_ids

  lifecycle {
    ignore_changes = [name]
  }
}

locals {
  rules = {
    for mapping in flatten(
      [
        for priority, value in var.settings : {
          name                         = value.name
          resource_group_name          = var.remote_objects.network_security_groups[try(value.network_security_group_definition.lz_key, var.client_config.landingzone_key)][value.network_security_group_definition.key].resource_group_name
          network_security_group_name  = var.remote_objects.network_security_groups[try(value.network_security_group_definition.lz_key, var.client_config.landingzone_key)][value.network_security_group_definition.key].name
          description                  = try(value.description, null)
          priority                     = priority
          direction                    = var.direction
          access                       = try(value.access, "Deny")
          protocol                     = try(title(value.protocol), "*")
          source_port_range            = try(value.source_port_range, null)
          source_port_ranges           = try(value.source_port_ranges, null)
          destination_port_range       = try(value.destination_port_range, null)
          destination_port_ranges      = try(value.destination_port_ranges, null)
          source_address_prefixes      = try(value.source_address_prefixes, null)
          destination_address_prefixes = try(value.destination_address_prefixes, null)

          source_address_prefix = can(value.source_address_prefix) || try(value.source_address_prefix_from_key, null) == null ? try(value.source_address_prefix, null) : coalesce(
            try(var.remote_objects[value.source_address_prefix_from_key.resource_type][try(value.source_address_prefix_from_key.lz_key, var.client_config.landingzone_key)][value.source_address_prefix_from_key.vnet_key].subnets[value.source_address_prefix_from_key.subnet_key].cidr[try(value.source_address_prefix_from_key.index, 0)], null),
            try(var.remote_objects[value.source_address_prefix_from_key.resource_type][try(value.source_address_prefix_from_key.lz_key, var.client_config.landingzone_key)][value.source_address_prefix_from_key.subnet_key].cidr[try(value.source_address_prefix_from_key.index, 0)], null)
          )

          destination_address_prefix = can(value.destination_address_prefix) || try(value.destination_address_prefix_from_key, null) == null ? try(value.destination_address_prefix, null) : coalesce(
            try(var.remote_objects[value.destination_address_prefix_from_key.resource_type][try(value.destination_address_prefix_from_key.lz_key, var.client_config.landingzone_key)][value.destination_address_prefix_from_key.vnet_key].subnets[value.destination_address_prefix_from_key.subnet_key].cidr[try(value.destination_address_prefix_from_key.index, 0)], null),
            try(var.remote_objects[value.destination_address_prefix_from_key.resource_type][try(value.destination_address_prefix_from_key.lz_key, var.client_config.landingzone_key)][value.destination_address_prefix_from_key.subnet_key].cidr[try(value.destination_address_prefix_from_key.index, 0)], null)
          )

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
                    var.remote_objects.application_security_groups[try(value.lz_key, var.client_config.landingzone_key)][key].id
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
                    var.remote_objects.application_security_groups[try(value.lz_key, var.client_config.landingzone_key)][key].id
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

    ) : mapping.priority => mapping
  }

}

output "rules" {
  value = azurerm_network_security_rule.rule
}