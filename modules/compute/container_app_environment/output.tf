output "id" {
  value = azurerm_container_app_environment.cae.id
}

output "default_domain" {
  value = azurerm_container_app_environment.cae.default_domain
}

output "docker_bridge_cidr" {
  value = try(var.settings.infrastructure_subnet_id, null) != null ? azurerm_container_app_environment.cae.docker_bridge_cidr : null
}

output "platform_reserved_cidr" {
  value = try(var.settings.infrastructure_subnet_id, null) != null ? azurerm_container_app_environment.cae.platform_reserved_cidr : null
}

output "platform_reserved_dns_ip_address" {
  value = try(var.settings.infrastructure_subnet_id, null) != null ? azurerm_container_app_environment.cae.platform_reserved_dns_ip_address : null
}

output "static_ip_address" {
  value = try(var.settings.internal_load_balancer_enabled, false) == true ? azurerm_container_app_environment.cae.static_ip_address : null
}
