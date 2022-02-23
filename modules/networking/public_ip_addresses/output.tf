output "id" {
  description = "The Public IP ID."
  value       = azurerm_public_ip.pip.id

}

output "ip_address" {
  description = "The IP address value that was allocated."
  value       = azurerm_public_ip.pip.ip_address

}

output "fqdn" {
  description = "Fully qualified domain name of the A DNS record associated with the public IP. domain_name_label must be specified to get the fqdn. This is the concatenation of the domain_name_label and the regionalized DNS zone."
  value       = azurerm_public_ip.pip.fqdn

}
