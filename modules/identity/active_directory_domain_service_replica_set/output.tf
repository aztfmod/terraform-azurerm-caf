output "id" {
  value       = azurerm_active_directory_domain_service_replica_set.addsrs.id
  description = "The ID of the Domain Service Replica Set."
}
output "domain_controller_ip_addresses" {
  value       = azurerm_active_directory_domain_service_replica_set.addsrs.domain_controller_ip_addresses
  description = "A list of subnet IP addresses for the domain controllers in this Replica Set, typically two."
}
output "external_access_ip_address" {
  value       = azurerm_active_directory_domain_service_replica_set.addsrs.external_access_ip_address
  description = "The publicly routable IP address for the domain controllers in this Replica Set."
}
output "service_status" {
  value       = azurerm_active_directory_domain_service_replica_set.addsrs.service_status
  description = "The current service status for the replica set."
}
