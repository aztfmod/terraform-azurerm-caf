resource "azurerm_dns_ns_record" "ns" {
  for_each = try(var.records.ns, {})

  name                = each.value.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = try(each.value.ttl, 300)
  records             = each.value.records
  tags                = merge(try(each.value.tags, {}), var.base_tags)
}
