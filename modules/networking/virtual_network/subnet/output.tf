
output "id" {
  value = azurerm_subnet.subnet.id

}

output "name" {
  value = azurerm_subnet.subnet.name

}

output "cidr" {
  value = var.address_prefixes

}