
# output name {
#   value       = azurecaf_name.manageddb.result
#   description = "SQL Managed DB Name"
# }

output id {
  value       = lookup(azurerm_template_deployment.sessionhost.outputs, "id")
  description = "Sessionhost Id"
}