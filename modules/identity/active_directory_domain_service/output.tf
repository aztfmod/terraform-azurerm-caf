output "id" {
  value       = azurerm_active_directory_domain_service.aadds.id
  description = "The ID of the Domain Service."
}
output "deployment_id" {
  value       = azurerm_active_directory_domain_service.aadds.deployment_id
  description = "A unique ID for the managed domain deployment."
}
output "resource_id" {
  value       = azurerm_active_directory_domain_service.aadds.resource_id
  description = "The Azure resource ID for the domain service."
}
output "secure_ldap" {
  value       = azurerm_active_directory_domain_service.aadds.secure_ldap
  description = "The publicly routable IP address for LDAPS clients to connect to."
}
output "domain_controller_ip_addresses" {
  value       = azurerm_active_directory_domain_service.aadds.initial_replica_set[0].domain_controller_ip_addresses
  description = "A list of subnet IP addresses for the domain controllers in this Replica Set, typically two."
}
output "external_access_ip_address" {
  value       = azurerm_active_directory_domain_service.aadds.initial_replica_set[0].external_access_ip_address
  description = "The publicly routable IP address for the domain controllers in this Replica Set."
}
output "service_status" {
  value       = azurerm_active_directory_domain_service.aadds.initial_replica_set[0].service_status
  description = "The current service status for the replica set."
}
output "location" {
  value       = azurerm_active_directory_domain_service.aadds.initial_replica_set[0].location
  description = "The Azure location in which the initialreplica set resides."
}