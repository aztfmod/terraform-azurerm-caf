resource "azurecaf_name" "addsrs" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_active_directory_domain_service_replica_set"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_active_directory_domain_service_replica_set" "addsrs" {
  domain_service_id = var.settings.domain_service_id
  location          = var.remote_objects.location
  subnet_id         = var.subnet_id
}
