output "id" {
  value     = azurerm_app_service_plan.asp.id
  sensitive = true
}

output "maximum_number_of_workers" {
  value     = azurerm_app_service_plan.asp.maximum_number_of_workers
  sensitive = true
}