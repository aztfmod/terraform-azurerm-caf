
#
# Azure Active Directory Groups
#

module "azuread_groups" {
  source   = "./modules/azuread/groups"
  for_each = var.azuread_groups

  global_settings = local.global_settings
  azuread_groups  = each.value
  tenant_id       = local.client_config.tenant_id
}

output "azuread_groups" {
  value = module.azuread_groups

}

module "azuread_groups_members" {
  source   = "./modules/azuread/groups_members"
  for_each = var.azuread_groups

  settings       = each.value
  azuread_groups = module.azuread_groups
  group_id       = module.azuread_groups[each.key].id
  azuread_apps   = module.azuread_applications
}
