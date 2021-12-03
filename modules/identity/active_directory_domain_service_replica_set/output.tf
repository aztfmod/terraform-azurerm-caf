output "id" {
  value       = azurerm_active_directory_domain_service_replica_set.aaddsrs.id
  description = "The ID of the Domain Service Replica Set."
}
output "domain_controller_ip_addresses" {
  value       = azurerm_active_directory_domain_service_replica_set.aaddsrs.domain_controller_ip_addresses
  description = "A list of subnet IP addresses for the domain controllers in this Replica Set, typically two."
}
output "external_access_ip_address" {
  value       = azurerm_active_directory_domain_service_replica_set.aaddsrs.external_access_ip_address
  description = "The publicly routable IP address for the domain controllers in this Replica Set."
}
output "service_status" {
  value       = azurerm_active_directory_domain_service_replica_set.aaddsrs.service_status
  description = "The current service status for the replica set."
}
output "location" {
  value       = var.location
  description = "Location of the replica set."
}