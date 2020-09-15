output "id" {
  value       = lookup(azurerm_template_deployment.ase.outputs, "id")
  description = "App Service Environment Resource Id"
}

output "name" {
  value       = azurecaf_name.ase.result
  description = "App Service Environment Name"
}

output "ilb_ip" {
  value = data.external.ase_ilb_ip.result.internalIpAddress
}