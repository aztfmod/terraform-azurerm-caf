output private_dns_zone {
  value     = azurerm_private_dns_zone.private_dns
  sensitive = true
}

output a_records {
  value     = azurerm_private_dns_a_record.a_records
  sensitive = true
}

output aaaa_records {
  value     = azurerm_private_dns_aaaa_record.aaaa_records
  sensitive = true
}

output cname_records {
  value     = azurerm_private_dns_cname_record.cname_records
  sensitive = true
}

output mx_records {
  value     = azurerm_private_dns_mx_record.mx_records
  sensitive = true
}

output ptr_records {
  value     = azurerm_private_dns_ptr_record.ptr_records
  sensitive = true
}

output srv_records {
  value     = azurerm_private_dns_srv_record.srv_records
  sensitive = true
}

output txt_records {
  value     = azurerm_private_dns_txt_record.txt_records
  sensitive = true
}