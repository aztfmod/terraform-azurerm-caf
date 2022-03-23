module "azuread_graph_group" {
  source   = "./modules/azuread_graph/group"
  for_each = local.azuread.azuread_groups

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
}
output "azuread_graph_group" {
  value = module.azuread_graph_group
}

module "azuread_graph_group_member" {
  source   = "./modules/azuread_graph/group_member"
  for_each = local.azuread.azuread_groups_membership

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    aad            = local.remote_objects
    azuread_groups = local.combined_objects_azuread_groups
  }
}
output "azuread_graph_group_member" {
  value = module.azuread_graph_group_member
}