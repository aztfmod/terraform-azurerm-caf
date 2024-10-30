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
  sku {
    name     = var.settings.sku.name
    tier     = try(var.settings.sku.tier, null)
    size     = try(var.settings.sku.size, null)
    family   = try(var.settings.sku.family, null)
    capacity = try(var.settings.sku.capacity, 1)
  }

  rai_policy_name        = try(var.settings.rai_policy_name, null)
  version_upgrade_option = try(var.settings.version_upgrade_option, null)
}
