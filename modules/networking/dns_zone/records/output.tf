output a {
  value = merge(
    azurerm_dns_a_record.a,
    azurerm_dns_a_record.a_dns_zone_record
  )
}

output caa {
  value = azurerm_dns_caa_record.caa
}

output cname {
  value = merge(
    azurerm_dns_cname_record.cname,
    azurerm_dns_cname_record.cname_dns_zone_record
  )
}