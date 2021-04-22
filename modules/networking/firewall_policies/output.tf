
output "id" {
  description = "The ID of the Azure Firewall Polict"
  value       = azurerm_firewall_policy.fwpol.id
}

output "name" {
  description = "Name of the firewall policy"
  value       = azurerm_firewall_policy.fwpol.name
}

output "resource_group_name" {
  value = var.resource_group_name
}
