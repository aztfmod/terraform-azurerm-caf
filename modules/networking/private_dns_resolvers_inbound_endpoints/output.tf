output "id" {
  value = azurerm_private_dns_resolver_inbound_endpoint.pvt_dns_resolver_inbound_endpoint.id
}

output "private_ip_address" {
  value = azurerm_private_dns_resolver_inbound_endpoint.pvt_dns_resolver_inbound_endpoint.ip_configurations[0].private_ip_address
}