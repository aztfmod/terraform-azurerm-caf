# module azuread_applications {
#   source  = "/tf/caf/modules/terraform-azuread-caf-aad-apps"

#   for_each = var.azuread_aad_apps

#   aad_apps            = each.value
#   aad_api_permissions = var.azuread_aad_api_permissions
#   keyvaults           = module.keyvault
#   prefix              = var.global_settings.prefix
# }

