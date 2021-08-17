
module "managed_identities" {
  source   = "./modules/security/managed_identity"
  for_each = var.managed_identities

  client_config   = local.client_config
  global_settings = local.global_settings
  name            = each.value.name
  resource_groups = local.combined_objects_resource_groups
  settings        = each.value
}

output "managed_identities" {
  value = module.managed_identities

}
