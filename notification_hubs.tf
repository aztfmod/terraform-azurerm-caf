module "notification_hub_namespaces" {
  source      = "./modules/messaging/notification_hub_namespaces"
  for_each = try(local.messaging.notification_hub_namespaces, {})

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

output "notification_hub_namespaces" {
  value = module.notification_hub_namespaces
}