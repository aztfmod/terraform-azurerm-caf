resource "azurecaf_name" "subscription_rule" {
  name          = var.settings.name
  resource_type = "azurerm_servicebus_subscription_rule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


# Arguments "sql_filter" and "correlation_filter" cannot appear at the same time despite setting to null, thus need to split
resource "azurerm_servicebus_subscription_rule" "sql_filter" {
  name = azurecaf_name.subscription_rule.result
  # resource_group_name = var.remote_objects.resource_group_name
  # namespace_name      = var.remote_objects.servicebus_namespace_name
  # topic_name          = var.remote_objects.servicebus_topic_name
  subscription_id = var.remote_objects.servicebus_subscription_id
  filter_type     = "SqlFilter"
  sql_filter      = var.settings.sql_filter
}