resource "azurerm_active_directory_domain_service_replica_set" "aaddsrs" {
  location = var.location

  domain_service_id = coalesce(
    try(var.settings.domain_service_id, null),
    try(var.remote_objects.active_directory_domain_service[var.settings.active_directory_domain_service.key].id, null),
    try(var.remote_objects.active_directory_domain_service[var.settings.active_directory_domain_service.domain_service_id].id, null),
    try(var.remote_objects.active_directory_domain_service[var.settings.active_directory_domain_service.id].id, null)
  )

  subnet_id = coalesce(
    try(var.remote_objects.vnets[var.settings.subnet.lz_key][var.settings.subnet.vnet_key].subnets[var.settings.subnet.key].id, null),
    try(var.remote_objects.vnets[var.client_config.landingzone_key][var.settings.subnet.vnet_key].subnets[var.settings.subnet.key].id, null),
    try(var.settings.subnet.id, null),
    try(var.settings.subnet_id, null)
  )

  lifecycle {
    ignore_changes = [
      subnet_id
    ]
  }
}
