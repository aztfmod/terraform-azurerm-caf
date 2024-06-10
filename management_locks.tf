locals {
  lockable_resource_types = distinct([ for lock, config in local.azurerm_management_locks:
    config.resource_type
  ])
  lockable_resources = merge( # T
    contains(local.lockable_resource_types, "storage_accounts") ? { "storage_accounts" = local.combined_objects_storage_accounts} : {},
    contains(local.lockable_resource_types, "resource_groups") ? { "resource_groups" = local.combined_objects_resource_groups} : {}
  )
  lock_info = { for lock, config in local.azurerm_management_locks:
    lock => {
      scope = try(config.resource_id, local.lockable_resources[config.resource_type][try(config.resource_lz_key, local.client_config.landingzone_key)][config.resource_key].id)
    }
  }
}

resource "azurerm_management_lock" "lock" {
  for_each = local.azurerm_management_locks
  name       = each.value.name
  scope      = local.lock_info[each.key].scope
  lock_level = each.value.lock_level
  notes      = each.value.notes
}

output "lockable_resource_types" {
  value = local.lockable_resource_types
}
output "lockable_resources" {
  value = local.lockable_resources
}
output "lock_info" {
  value = local.lock_info
}