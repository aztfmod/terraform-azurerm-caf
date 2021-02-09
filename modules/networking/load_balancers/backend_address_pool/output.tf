output id {
  value = azurerm_lb_backend_address_pool.backend_address_pool.id
}

output backend_address {
  value = azurerm_lb_backend_address_pool.backend_address_pool.backend_address
}

output backend_ip_configurations {
  value = azurerm_lb_backend_address_pool.backend_address_pool.backend_ip_configurations
}

output load_balancing_rules {
  value = azurerm_lb_backend_address_pool.backend_address_pool.load_balancing_rules
}

output outbound_rules {
  value = azurerm_lb_backend_address_pool.backend_address_pool.outbound_rules
}