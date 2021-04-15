resource "azurerm_management_lock" "lock" {
  name       = var.settings.name
  scope      = var.subscription_id
  lock_level = var.settings.lock_level #  Possible values are CanNotDelete and ReadOnly
  notes      = try(var.settings.notes, null)
}

