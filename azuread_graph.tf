module "azuread_graph_group" {
  source   = "./modules/azuread_graph/group"
  for_each = local.azuread.azuread_groups

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
}
output "azuread_groups" {
  value = module.azuread_graph_group
}
output "azuread_graph_group" {
  value = module.azuread_graph_group
}

module "azuread_graph_group_member" {
  source   = "./modules/azuread_graph/group_member"
  for_each = local.azuread.azuread_groups_membership

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    aad            = local.azuread_objects
    azuread_groups = local.combined_objects_azuread_groups
  }
}

output "azuread_graph_group_member" {
  value = module.azuread_graph_group_member
}
output "azuread_group_member" {
  value = module.azuread_graph_group_member
}

module "azuread_graph_application" {
  source   = "./modules/azuread_graph/application"
  for_each = local.azuread.azuread_applications

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  base_tags       = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  remote_objects = {
  }
}

output "aad_apps" {
  value = module.azuread_graph_application
}
output "azuread_applications" {
  value = module.azuread_graph_application
}
output "azuread_graph_application" {
  value = module.azuread_graph_application
}

module "azuread_graph_administrative_unit" {
  source   = "./modules/azuread_graph/administrative_unit"
  for_each = local.azuread.azuread_administrative_units

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    #aad = local.aad
  }
}
output "azuread_graph_administrative_unit" {
  value = module.azuread_graph_administrative_unit
}

module "azuread_graph_administrative_unit_member" {
  source   = "./modules/azuread_graph/administrative_unit_member"
  for_each = local.azuread.azuread_administrative_unit_members

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    aad                          = local.azuread_objects
    azuread_administrative_units = local.combined_objects_azuread_administrative_units
  }
}
output "azuread_graph_administrative_unit_member" {
  value = module.azuread_graph_administrative_unit_member
}

module "azuread_graph_application_certificate" {
  source   = "./modules/azuread_graph/application_certificate"
  for_each = local.azuread.azuread_application_certificates

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    azuread_applications = local.combined_objects_azuread_applications
  }
}
output "azuread_graph_application_certificate" {
  value = module.azuread_graph_application_certificate
}

module "azuread_graph_application_federated_identity_credential" {
  source   = "./modules/azuread_graph/application_federated_identity_credential"
  for_each = local.azuread.azuread_application_federated_identity_credentials

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    azuread_applications = local.combined_objects_azuread_applications
    managed_identities   = local.combined_objects_managed_identities
  }
}
output "azuread_graph_application_federated_identity_credential" {
  value = module.azuread_graph_application_federated_identity_credential
}

module "azuread_graph_application_password" {
  source   = "./modules/azuread_graph/application_password"
  for_each = local.azuread.azuread_application_passwords

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    azuread_applications = local.combined_objects_azuread_applications
  }
}
output "azuread_graph_application_password" {
  value = module.azuread_graph_application_password
}

module "azuread_graph_application_pre_authorized" {
  source   = "./modules/azuread_graph/application_pre_authorized"
  for_each = local.azuread.azuread_application_pre_authorizeds

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    #aad = local.aad
  }
}
output "azuread_graph_application_pre_authorized" {
  value = module.azuread_graph_application_pre_authorized
}

module "azuread_graph_app_role_assignment" {
  source   = "./modules/azuread_graph/app_role_assignment"
  for_each = local.azuread.azuread_app_role_assignments

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    aad = local.azuread_objects
  }
}
output "azuread_graph_app_role_assignment" {
  value = module.azuread_graph_app_role_assignment
}

module "azuread_graph_conditional_access_policy" {
  source   = "./modules/azuread_graph/conditional_access_policy"
  for_each = local.azuread.azuread_conditional_access_policies

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    #aad = local.aad
  }
}
output "azuread_graph_conditional_access_policy" {
  value = module.azuread_graph_conditional_access_policy
}

module "azuread_graph_custom_directory_role" {
  source   = "./modules/azuread_graph/custom_directory_role"
  for_each = local.azuread.azuread_custom_directory_roles

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    #aad = local.aad
  }
}
output "azuread_graph_custom_directory_role" {
  value = module.azuread_graph_custom_directory_role
}

module "azuread_graph_directory_role" {
  source   = "./modules/azuread_graph/directory_role"
  for_each = local.azuread.azuread_directory_roles

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    #aad = local.aad
  }
}
output "azuread_graph_directory_role" {
  value = module.azuread_graph_directory_role
}

module "azuread_graph_directory_role_member" {
  source   = "./modules/azuread_graph/directory_role_member"
  for_each = local.azuread.azuread_directory_role_members

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    #aad = local.aad
  }
}
output "azuread_graph_directory_role_member" {
  value = module.azuread_graph_directory_role_member
}

module "azuread_graph_invitation" {
  source   = "./modules/azuread_graph/invitation"
  for_each = local.azuread.azuread_invitations

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    #aad = local.aad
  }
}
output "azuread_graph_invitation" {
  value = module.azuread_graph_invitation
}

module "azuread_graph_named_location" {
  source   = "./modules/azuread_graph/named_location"
  for_each = local.azuread.azuread_named_locations

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    #aad = local.aad
  }
}
output "azuread_graph_named_location" {
  value = module.azuread_graph_named_location
}

module "azuread_graph_service_principal" {
  source   = "./modules/azuread_graph/service_principal"
  for_each = local.azuread.azuread_service_principals

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  base_tags       = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  remote_objects = {
    azuread_applications = local.combined_objects_azuread_applications
  }
}
output "azuread_graph_service_principal" {
  value = module.azuread_graph_service_principal
}

module "azuread_graph_service_principal_certificate" {
  source   = "./modules/azuread_graph/service_principal_certificate"
  for_each = local.azuread.azuread_service_principal_certificates

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    azuread_service_principals = local.combined_objects_azuread_service_principals
  }
}
output "azuread_graph_service_principal_certificate" {
  value = module.azuread_graph_service_principal_certificate
}

module "azuread_graph_service_principal_delegated_permission_grant" {
  source   = "./modules/azuread_graph/service_principal_delegated_permission_grant"
  for_each = local.azuread.azuread_service_principal_delegated_permission_grants

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    #aad = local.aad
  }
}
output "azuread_graph_service_principal_delegated_permission_grant" {
  value = module.azuread_graph_service_principal_delegated_permission_grant
}

module "azuread_graph_service_principal_password" {
  source   = "./modules/azuread_graph/service_principal_password"
  for_each = local.azuread.azuread_service_principal_passwords

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    service_principal_application_id = can(each.value.service_principal.application_id) ? each.value.service_principal.application_id : local.combined_objects_azuread_service_principals[try(each.value.service_principal.lz_key, local.client_config.landingzone_key)][each.value.service_principal.key].application_id
    azuread_service_principals       = local.combined_objects_azuread_service_principals
    keyvaults                        = local.combined_objects_keyvaults
  }
}
output "azuread_graph_service_principal_password" {
  value = module.azuread_graph_service_principal_password
}

module "azuread_graph_user" {
  source   = "./modules/azuread_graph/user"
  for_each = local.azuread.azuread_users

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    keyvaults = local.combined_objects_keyvaults
  }
}
output "azuread_graph_user" {
  value = module.azuread_graph_user
}

