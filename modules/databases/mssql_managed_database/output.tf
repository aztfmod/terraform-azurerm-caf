
output "name" {
  value       = azurecaf_name.manageddb.result
  description = "SQL Managed DB Name"
}

output "id" {
  value       = jsondecode(azapi_resource.manageddb.output).properties.outputs.id.value
  description = "SQL Managed DB Id"
}