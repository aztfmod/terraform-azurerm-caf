output "id" {
  description = "The ID of the Application Insights standard web test."
  value       = jsondecode(azapi_resource.appiwt.output).properties.id
}
