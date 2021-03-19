resource "azurerm_dns_caa_record" "caa" {
  for_each = try(var.records.caa, {})

  name                = each.value.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = try(each.value.ttl, 300)
  tags                = merge(var.base_tags, try(each.value.tags, {}))

  dynamic "record" {
    for_each = each.value.records

    content {
      flags = record.value.flags
      tag   = record.value.tag
      value = record.value.value
    }
  }
}