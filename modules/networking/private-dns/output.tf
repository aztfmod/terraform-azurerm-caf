output "id" {
  value = azurerm_private_dns_zone.private_dns.id

}

output "name" {
  value = azurerm_private_dns_zone.private_dns.name

}

output "resource_group_name" {
  value = local.resource_group_name

}

output "base_tags" {
  value = local.tags
}