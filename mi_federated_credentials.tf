module "mi_federated_credentials" {
  source   = "./modules/security/mi_federated_credentials/"
  for_each = var.mi_federated_credentials
  depends_on = [module.managed_identities]
  client_config           = local.client_config
  resource_groups         = local.combined_objects_resource_groups
  settings                = each.value
  managed_identities      = local.combined_objects_managed_identities
}

output "mi_federated_credentials" {
  value = module.mi_federated_credentials
}
