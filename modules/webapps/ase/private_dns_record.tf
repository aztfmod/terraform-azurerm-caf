resource "azurerm_private_dns_a_record" "a_records" {
  for_each = {
    for key, value in try(var.settings.records.a_records, {}) : key => value
    if try(var.private_dns, {}) != {}
  }

  name                = each.value.name
  resource_group_name = var.private_dns.resource_group_name
  zone_name           = var.private_dns.name
  ttl                 = each.value.ttl
  records             = each.value.records
}