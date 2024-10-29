// resource "azurecaf_name" "service" {
//   name          = var.settings.name
//   prefixes      = var.global_settings.prefixes
//   resource_type = "azurerm_cognitive_deployment"
//   random_length = var.global_settings.random_length
//   clean_input   = true
//   passthrough   = var.global_settings.passthrough
//   use_slug      = var.global_settings.use_slug
// }

resource "azurerm_cognitive_deployment" "service" {
  name                 = var.settings.name
  cognitive_account_id = var.cognitive_account_id
  model {
    format  = var.settings.model.format
    name    = var.settings.model.name
    version = try(var.settings.model.version, null)
  }
  scale {
    type     = var.settings.scale.type
    tier     = try(var.settings.scale.tier, null)
    size     = try(var.settings.scale.size, null)
    family   = try(var.settings.scale.family, null)
    capacity = try(var.settings.scale.capacity, null)
  }

  rai_policy_name        = try(var.settings.rai_policy_name, null)
  version_upgrade_option = try(var.settings.version_upgrade_option, null)
}
