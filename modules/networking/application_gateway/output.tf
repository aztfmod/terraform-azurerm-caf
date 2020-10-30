output id {
  value     = azurerm_application_gateway.agw.id
  sensitive = true
}

output private_ip_address {
  value = local.private_ip_address
}
