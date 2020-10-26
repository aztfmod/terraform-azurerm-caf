
module "storage_accounts" {
  source   = "./modules/storage_account"
  for_each = var.storage_accounts

  global_settings     = local.global_settings
  storage_account     = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  vnets               = try(each.value.private_endpoints, {}) == {} ? null : local.combined_objects_networking
  private_endpoints   = try(each.value.private_endpoints, {})
  resource_groups     = try(each.value.private_endpoints, {}) == {} ? null : module.resource_groups
  tfstates            = var.tfstates
  use_msi             = var.use_msi
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}

}

module diagnostic_storage_accounts {
  source   = "./modules/storage_account"
  for_each = var.diagnostic_storage_accounts

  global_settings     = local.global_settings
  storage_account     = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

output storage_accounts {
  value = module.storage_accounts
}
