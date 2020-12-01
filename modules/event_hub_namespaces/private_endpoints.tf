

# #
# # Private endpoint
# #

# module private_endpoint {
#   source   = "../networking/private_endpoint"
#   for_each = try(var.private_endpoints, {})

#   resource_id         = azurerm_eventhub_namespace.evh.id
#   name                = each.value.name
#   location            = var.resource_groups[each.value.resource_group_key].location
#   resource_group_name = var.resource_groups[each.value.resource_group_key].name
#   subnet_id           = var.subnet_id
#   settings            = each.value
#   global_settings     = var.global_settings
#   base_tags           = local.tags
# }
