module azuread_applications {
  source     = "/tf/caf/modules/terraform-azuread-caf-aad-apps"
  depends_on = [module.keyvault_access_policies]

  azuread_apps            = var.azuread_apps
  azuread_api_permissions = var.azuread_api_permissions
  keyvaults               = module.keyvaults
  prefix                  = var.global_settings.prefix
}

