# naming convention
resource "azurecaf_name" "egdt" {
  name          = var.name
  resource_type = "azurerm_eventgrid_domain_topic"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Per options https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_domain_topic

resource "azurerm_eventgrid_domain_topic" "egdt" {
  name                = var.name
  domain_name         = var.domain_name
  resource_group_name = var.resource_group_name
}
