module "azuread_federated_credentials" {
  source               = "./modules/azuread/federated_credentials/"
  for_each             = local.azuread.azuread_federated_credentials
  depends_on           = [module.azuread_applications_v1]
  client_config        = local.client_config
  settings             = each.value
  azuread_applications = local.combined_objects_azuread_applications
}

output "azuread_federated_credentials" {
  value = module.azuread_federated_credentials
}
