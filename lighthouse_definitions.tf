module "lighthouse_definitions" {
  source = "./modules/security/lighthouse_definition"

  for_each = local.security.lighthouse_definitions

  client_config = local.client_config
  settings      = each.value
  resources = {
    azuread_apps       = local.combined_objects_azuread_applications
    azuread_groups     = local.combined_objects_azuread_groups
    azuread_users      = local.combined_objects_azuread_users
    managed_identities = local.combined_objects_managed_identities
    resource_groups    = local.combined_objects_resource_groups
    subscriptions      = local.combined_objects_subscriptions
  }
}