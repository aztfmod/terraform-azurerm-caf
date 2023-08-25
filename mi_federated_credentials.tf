module "mi_federated_credentials" {
  source             = "./modules/security/mi_federated_credentials/"
  for_each           = var.mi_federated_credentials
  depends_on         = [module.managed_identities]
  client_config      = local.client_config
  resource_group     = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  settings           = each.value
  managed_identities = local.combined_objects_managed_identities
}

output "mi_federated_credentials" {
  value = module.mi_federated_credentials
}
