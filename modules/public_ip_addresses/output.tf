output id {
  value     = azurerm_public_ip.pip.id
  sensitive = true
}

output ip_address {
  value     = azurerm_public_ip.pip.ip_address
  sensitive = true
}

output fqdn {
  value     = azurerm_public_ip.pip.fqdn
  sensitive = true
}
