output "id" {
  description = "The Public IP Prefix ID."
  value       = azurerm_public_ip_prefix.pip_prefix.id

}

output "ip_prefix" {
  description = "The IP address prefix that was allocated."
  value       = azurerm_public_ip_prefix.pip_prefix.ip_prefix

}

