output "name" {
  value       = azapi_resource.aro.name
  description = "Specifies the name of the managed environment."
}

output "id" {
  value       = azapi_resource.aro.id
  description = "Specifies the resource id of the managed environment."
}

# See for advanced attributes
output "url" {
  value       = azapi_resource.aro
  description = "Specifies the URL."
}