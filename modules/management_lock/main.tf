resource "azurerm_management_lock" "lock" {
  name = var.name
  scope = coalesce(
    var.resource_id,
    var.remote_objects[var.resource_type][var.resource_lz_key][var.resource_key].id
  )
  lock_level = var.lock_level
  notes      = var.notes
}
