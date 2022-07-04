output "id" {
  value = azurerm_iothub_dps_shared_access_policy.access_policy.id
}

output "primary_key" {
  value = azurerm_iothub_dps_shared_access_policy.access_policy.primary_key
}

output "primary_connection_string" {
  value = azurerm_iothub_dps_shared_access_policy.access_policy.primary_connection_string
}

output "secondary_key" {
  value = azurerm_iothub_dps_shared_access_policy.access_policy.secondary_key
}

output "secondary_connection_string" {
  value = azurerm_iothub_dps_shared_access_policy.access_policy.secondary_connection_string
}
