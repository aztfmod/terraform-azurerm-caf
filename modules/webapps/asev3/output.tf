output "id" {
  value       = azurerm_app_service_environment_v3.asev3.id
  description = "App Service Environment Resource Id"
}

output "name" {
  value       = azurecaf_name.asev3.result
  description = "App Service Environment Name"
}

output "internal_inbound_ip_addresses" {
  value = azurerm_app_service_environment_v3.asev3.internal_inbound_ip_addresses
}

output "external_inbound_ip_addresses" {
  value = azurerm_app_service_environment_v3.asev3.external_inbound_ip_addresses
}

output "subnet_id" {
  value = var.subnet_id
}

output "a_records" {
  value = azurerm_private_dns_a_record.a_records
}