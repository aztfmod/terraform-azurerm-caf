locals {
  management_locks = merge(flatten([
    for resource_type, resources in var.management_locks : {
      for key, resource in resources : key => merge(resource, {
        resource_type = resource_type,
      })
    } if resource_type != "ids"
  ])...)
}

module "management_locks" {
  source   = "./modules/management_lock"
  for_each = local.management_locks

  global_settings = local.global_settings
  client_config   = local.client_config
  remote_objects  = local.remote_objects

  name            = each.value.name
  resource_type   = each.value.resource_type
  resource_lz_key = try(each.value.lz_key, local.client_config.landingzone_key)
  resource_key    = each.value.key
  lock_level      = each.value.level
  notes           = try(each.value.notes, null)
}

module "management_locks_with_ids" {
  source   = "./modules/management_lock"
  for_each = try(var.management_locks.ids, {})

  global_settings = local.global_settings
  client_config   = local.client_config

  name        = each.value.name
  resource_id = each.value.id
  lock_level  = each.value.level
  notes       = try(each.value.notes, null)
}
