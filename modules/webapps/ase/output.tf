output "id" {
  value       = data.azurerm_app_service_environment.ase.id
  description = "App Service Environment Resource Id"
}

output "name" {
  value       = azurecaf_name.ase.result
  description = "App Service Environment Name"
}

output "ilb_ip" {
  value = data.azurerm_app_service_environment.ase.internal_ip_address
}

output "subnet_id" {
  value = var.subnet_id
}

output "zone" {
  value = var.zone
}

output "a_records" {
  value = azurerm_private_dns_a_record.a_records
}