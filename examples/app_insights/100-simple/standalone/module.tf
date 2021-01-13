module "caf" {
  source          = "../../../../"
  global_settings = var.global_settings
  tags            = var.tags
  resource_groups = var.resource_groups
  webapp = {
    azurerm_application_insights = var.azurerm_application_insights
  }
}

