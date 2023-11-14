resource "azurerm_dns_ns_record" "ns" {
  for_each = {
    for key, value in try(var.records.ns, {}) : key => value
    if try(value.resource_id, null) == null
  }

  name                = each.value.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = try(each.value.ttl, 300)
  records             = each.value.records
  tags                = merge(var.base_tags, try(each.value.tags, {}))
}

resource "azurerm_dns_ns_record" "ns_dns_zone" {
  for_each = {
    for key, value in try(var.records.ns, {}) : key => value
    if try(value.resource_id.dns_zone, null) != null
  }

  name                = each.value.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = try(each.value.ttl, 300)
  records             = var.resource_ids.dns_zones[try(each.value.resource_id.dns_zone.lz_key, var.client_config.landingzone_key)][each.value.resource_id.dns_zone.key].name_servers
  tags                = merge(var.base_tags, try(each.value.tags, {}))
}
