
resource "azurecaf_name" "pep" {
  name          = var.name
  resource_type = "azurerm_private_endpoint"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_private_endpoint" "pep" {
  for_each = toset(var.subresource_names)

  name                = format("%s-%s", azurecaf_name.pep.result, each.key)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = local.tags

  private_service_connection {
    name                           = format("%s-%s", var.settings.private_service_connection.name, replace(each.key, " ", "-"))
    private_connection_resource_id = var.resource_id
    is_manual_connection           = try(var.settings.private_service_connection.is_manual_connection, false)
    subresource_names              = [each.key]
    request_message                = try(var.settings.private_service_connection.request_message, null)
  }

  dynamic "private_dns_zone_group" {
    for_each = can(var.settings.private_dns) ? [var.settings.private_dns] : []

    content {
      name = private_dns_zone_group.value.zone_group_name
      private_dns_zone_ids = concat(
        flatten([
          for key in try(private_dns_zone_group.value.keys, []) : [
            can(private_dns_zone_group.value.lz_key) ? var.private_dns[private_dns_zone_group.value.lz_key][key].id : var.private_dns[var.client_config.landingzone_key][key].id
          ]
        ]),
        try(private_dns_zone_group.value.ids, [])
      )
    }
  }
  lifecycle {
    ignore_changes = [
      resource_group_name, location
    ]
  }
}

# locals {
#   private_dns_zone_ids = flatten([
#     for key in try(var.settings.private_dns.keys, []) : [
#       try(var.private_dns[var.client_config.landingzone_key][key].id, var.private_dns[var.settings.private_dns.lz_key][key].id)
#     ]
#   ])
# }
