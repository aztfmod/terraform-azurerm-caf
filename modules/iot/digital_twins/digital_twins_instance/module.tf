
# naming convention
resource "azurecaf_name" "adt" {
  name          = var.name
  resource_type = "azurerm_digital_twins_instance"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Per options https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_instance
resource "azurerm_digital_twins_instance" "adt" {
  name                = azurecaf_name.adt.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
}