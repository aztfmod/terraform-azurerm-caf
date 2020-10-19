# naming convention
# Not supported yet in the provider

# resource "azurecaf_name" "msi" {
#   name          = var.settings.name
#   resource_type = "azurerm_user_assigned_identity"
#   prefixes      = [var.global_settings.prefix]
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
# }

resource "azurerm_user_assigned_identity" "msi" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.global_settings.passthrough ? var.name : format("%s-%s", var.global_settings.prefix, var.name)
}

