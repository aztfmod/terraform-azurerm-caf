
output "name" {
  value       = azapi_resource.sqlmanageddatabase.name
  description = "SQL Managed DB Name"
}

output "id" {
  value       = azapi_resource.sqlmanageddatabase.id
  description = "SQL Managed DB Id"
}


output "finaltags" {
  value = local.tags
}


