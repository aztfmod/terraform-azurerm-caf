
resource "azurerm_private_dns_zone" "private_dns" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = local.tags
}


resource "azurerm_private_dns_a_record" "a_records" {
  for_each = try(var.records.a_records, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl
  records             = each.value.records
}

resource "azurerm_private_dns_aaaa_record" "aaaa_records" {
  for_each = try(var.records.aaaa_records, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl
  records             = each.value.records
}

resource "azurerm_private_dns_cname_record" "cname_records" {
  for_each = try(var.records.cname_records, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl
  record              = each.value.records
}

resource "azurerm_private_dns_mx_record" "mx_records" {
  for_each = try(var.records.mx_records, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = each.value.records

    content {
      preference = record.value.preference
      exchange   = record.value.exchange
    }
  }
}

resource "azurerm_private_dns_ptr_record" "ptr_records" {
  for_each = try(var.records.ptr_records, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl
  records             = each.value.records
}

resource "azurerm_private_dns_srv_record" "srv_records" {
  for_each = try(var.records.srv_records, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = each.value.records

    content {
      priority = record.value.priority
      weight   = record.value.weight
      port     = record.value.port
      target   = record.value.target
    }
  }
}

resource "azurerm_private_dns_txt_record" "txt_records" {
  for_each = try(var.records.txt_records, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = each.value.records

    content {
      value = record.value.value
    }
  }
}