output id {
  value     = azurerm_application_gateway.agw.id
  
}

output private_ip_address {
  value = local.private_ip_address
}
