resource "azurerm_dns_ptr_record" "ptr" {
  for_each = try(var.records.ptr, {})

  name                = each.value.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = try(each.value.ttl, 300)
  records             = each.value.records
  tags                = merge(var.base_tags, try(each.value.tags, {}))
}
