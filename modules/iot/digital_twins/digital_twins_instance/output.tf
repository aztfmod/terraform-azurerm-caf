output "id" {
  value       = azurerm_digital_twins_instance.adt.id
  description = "The ID of the Digital Twins instance."
}

output "host_name" {
  value       = azurerm_digital_twins_instance.adt.host_name
  description = "The Api endpoint to work with this Digital Twins instance."
}