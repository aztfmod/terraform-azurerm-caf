output "id" {
  value = azurerm_app_service_plan.asp.id
}

output "maximum_number_of_workers" {
  value = azurerm_app_service_plan.asp.maximum_number_of_workers
}

output "ase_id" {
  value = var.app_service_environment_id
}