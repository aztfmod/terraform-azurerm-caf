resource "azurecaf_name" "mpls" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" # "azurerm_monitor_private_link_scope"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "mplss" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" # "azurerm_monitor_private_link_scoped_service"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_monitor_private_link_scope" "mpls" {
  name                = azurecaf_name.mpls.result
  resource_group_name = var.resource_group_name
}

resource "azurerm_monitor_private_link_scoped_service" "mplss" {
  name                = azurecaf_name.mplss.result
  resource_group_name = var.resource_group_name
  scope_name          = azurerm_monitor_private_link_scope.mpls.name
  linked_resource_id  = var.linked_resource_id
  depends_on          = [module.private_endpoint]
}
