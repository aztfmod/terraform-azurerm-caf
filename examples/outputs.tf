
output "objects" {
  value = tomap(
    { (var.landingzone.key) = {
      for key, value in module.example : key => value
      if try(value, {}) != {}
      }
    }
  )
  sensitive = true
}
output "combined_objects_mssql_managed_instances" {
  value = module.example.combined_objects_mssql_managed_instances
}

output "combined_objects_mssql_managed_instances_secondary" {
  value = module.example.combined_objects_mssql_managed_instances_secondary
}