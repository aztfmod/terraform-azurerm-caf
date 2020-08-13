output "az_firewall_config" {
  #old output kept for compatibility reason with v0.1
  #might nolonger be supported in future versions
  description = "Outputs a map with az_fw_name,az_fw_id,az_ipconfig,az_object - to be deprecated in future version"
  value = {
    az_fw_name  = azurerm_firewall.az_firewall.name
    az_fw_id    = azurerm_firewall.az_firewall.id
    az_ipconfig = azurerm_firewall.az_firewall.ip_configuration
    az_object   = azurerm_firewall.az_firewall
  }
}

output "id" {
  description = "Output the object ID"
  value       = azurerm_firewall.az_firewall.id
}

output "name" {
  description = "Output the object name"
  value       = azurerm_firewall.az_firewall.name
}

output "object" {
  description = "Output the full object"
  value       = azurerm_firewall.az_firewall
}