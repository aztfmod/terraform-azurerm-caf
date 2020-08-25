module private_endpoint {
  source   = "../networking/private_endpoint"
  for_each = try(var.private_endpoints, {})

  resource_id         = azurerm_storage_account.stg.id
  name                = format("%s-to-%s-%s", each.value.name, each.value.vnet_key, each.value.subnet_key)
  location            = lookup(each.value, "region", null) == null ? var.resource_groups[each.value.resource_group_key].location : var.global_settings.regions[each.value.region]
  resource_group_name = var.resource_groups[each.value.resource_group_key].name
  subnet_id           = var.vnets[each.value.vnet_key].subnets[each.value.subnet_key].id
  settings            = each.value
}
