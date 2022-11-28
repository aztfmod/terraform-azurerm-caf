resource "azurerm_dns_cname_record" "cname" {
  for_each = {
    for key, value in try(var.records.cname, {}) : key => value
    if try(value.resource_id, null) == null
  }

  name                = each.value.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = try(each.value.ttl, 300)
  record              = try(each.value.record, null)
  tags                = merge(var.base_tags, try(each.value.tags, {}))
}

resource "azurerm_dns_cname_record" "cname_dns_zone_record" {
  for_each = {
    for key, value in try(var.records.cname, {}) : key => value
    if try(value.resource_id.dns_zone_record, null) != null
  }

  name                = each.value.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = try(each.value.ttl, 300)
  tags                = merge(var.base_tags, try(each.value.tags, {}))
  target_resource_id  = azurerm_dns_cname_record.cname[each.value.resource_id.dns_zone_record.key].id
}