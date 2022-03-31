locals {
  azuread_objects = {
    azuread_applications       = try(local.combined_objects_azuread_applications, null)
    azuread_users              = try(local.combined_objects_azuread_users, null)
    azuread_groups             = try(local.combined_objects_azuread_groups, null)
    azuread_service_principals = try(local.combined_objects_azuread_service_principals, null)
    azuread_directory_roles    = try(local.combined_objects_azuread_directory_roles, null)
    managed_identities         = try(local.combined_objects_managed_identities, null)
    mssql_servers              = try(local.combined_objects_mssql_servers, null)
  }
}