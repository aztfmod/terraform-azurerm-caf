output "a" {
  value = merge(
    azurerm_dns_a_record.a,
    azurerm_dns_a_record.a_dns_zone_record,
    azurerm_dns_a_record.a_public_ip_address
  )
}

output "aaaa" {
  value = merge(
    azurerm_dns_aaaa_record.aaaa,
    azurerm_dns_aaaa_record.aaaa_dns_zone_record
  )
}

output "caa" {
  value = azurerm_dns_caa_record.caa
}

output "cname" {
  value = merge(
    azurerm_dns_cname_record.cname,
    azurerm_dns_cname_record.cname_dns_zone_record
  )
}

output "mx" {
  value = azurerm_dns_mx_record.mx
}

output "ns" {
  value = azurerm_dns_ns_record.ns
}

output "ptr" {
  value = azurerm_dns_ptr_record.ptr
}

output "srv" {
  value = azurerm_dns_srv_record.srv
}

output "txt" {
  value = azurerm_dns_txt_record.txt
}