locals {
  # CAF landing zones can retrieve remote objects from a different landing zone and the 
  # combined_objects will merge it with the local objects 
  combined_objects_aks_clusters               = merge(map(var.current_landingzone_key, module.aks_clusters), try(var.remote_objects.aks_clusters, {}))
  combined_objects_app_service_plans          = merge(map(var.current_landingzone_key, module.app_service_plans), try(var.remote_objects.app_service_plans, {}))
  combined_objects_azuread_applications       = merge(map(var.current_landingzone_key, module.azuread_applications), try(var.remote_objects.azuread_applications, {}))
  combined_objects_azuread_groups             = merge(map(var.current_landingzone_key, module.azuread_groups), try(var.remote_objects.azuread_groups, {}))
  combined_objects_azuread_users              = merge(map(var.current_landingzone_key, module.azuread_users), try(var.remote_objects.azuread_users, {}))
  combined_objects_azure_container_registries = merge(map(var.current_landingzone_key, module.container_registry), try(var.remote_objects.container_registry, {}))
  combined_objects_keyvaults                  = merge(map(var.current_landingzone_key, module.keyvaults), try(var.remote_objects.keyvaults, {}))
  combined_objects_managed_identities         = merge(map(var.current_landingzone_key, module.managed_identities), try(var.remote_objects.managed_identities, {}))
  combined_objects_mssql_servers              = merge(map(var.current_landingzone_key, module.mssql_servers), try(var.remote_objects.mssql_servers, {}))
  combined_objects_networking                 = merge(map(var.current_landingzone_key, module.networking), try(var.remote_objects.vnets, {}))
  combined_objects_public_ip_addresses        = merge(map(var.current_landingzone_key, module.public_ip_addresses), try(var.remote_objects.public_ip_addresses, {}))
  combined_objects_private_dns                = merge(map(var.current_landingzone_key, module.private_dns), try(var.remote_objects.private_dns, {}))
  combined_objects_resource_groups            = merge(map(var.current_landingzone_key, module.resource_groups), try(var.remote_objects.resource_groups, {}))
  combined_objects_storage_accounts           = merge(try(var.remote_objects.storage_accounts, {}), map(var.current_landingzone_key, module.storage_accounts))
  combined_objects_synapse_workspaces         = merge(map(var.current_landingzone_key, module.synapse_workspaces), try(var.remote_objects.synapse_workspaces, {}))
}