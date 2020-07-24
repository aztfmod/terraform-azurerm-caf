
module "virtual_machine" {
  source = "./modules/virtual_machine"

  for_each = var.virtual_machines

  global_settings           = var.global_settings
  tags                      = var.tags
  location                  = lookup(each.value, "location", azurerm_resource_group.rg[each.value.resource_group_key].location)
  resource_group_name       = azurerm_resource_group.rg[each.value.resource_group_key].name

  networking_interfaces     = each.value.networking_interfaces
  virtual_machine_settings  = each.value.virtual_machine_settings
  vnets                     = module.virtual_network
  managed_identities        = azurerm_user_assigned_identity.msi
  data_disks                = lookup(each.value, "data_disks", {})
}
