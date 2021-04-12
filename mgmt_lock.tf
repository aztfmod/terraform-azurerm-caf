module "management_locks" {
  source   = "./modules/security/management_locks"
  for_each = try(local.security.management_locks, {})

  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  client_config       = local.client_config
  subscription_id     = data.azurerm_subscription.primary.subscription_id
  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}

}