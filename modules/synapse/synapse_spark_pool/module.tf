
resource "azurecaf_name" "sysp" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_synapse_spark_pool"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_synapse_spark_pool" "sysp" {
  name                 = azurecaf_name.sysp.result
  synapse_workspace_id = can(var.settings.synapse_workspace.id) ? var.settings.synapse_workspace.id : var.remote_objects.synapse_workspace[try(var.settings.synapse_workspace.lz_key, var.client_config.landingzone_key)][var.settings.synapse_workspace.key].id
  node_size_family     = var.settings.node_size_family
  node_size            = var.settings.node_size
  node_count           = try(var.settings.node_count, null)
  dynamic "auto_scale" {
    for_each = try(var.settings.auto_scale, null) != null ? [var.settings.auto_scale] : []
    content {
      max_node_count = try(auto_scale.value.max_node_count, null)
      min_node_count = try(auto_scale.value.min_node_count, null)
    }
  }
  dynamic "auto_pause" {
    for_each = try(var.settings.auto_pause, null) != null ? [var.settings.auto_pause] : []
    content {
      delay_in_minutes = try(auto_pause.value.delay_in_minutes, null)
    }
  }
  cache_size                          = try(var.settings.cache_size, null)
  compute_isolation_enabled           = try(var.settings.compute_isolation_enabled, null)
  dynamic_executor_allocation_enabled = try(var.settings.dynamic_executor_allocation_enabled, null)
  dynamic "library_requirement" {
    for_each = try(var.settings.library_requirement, null) != null ? [var.settings.library_requirement] : []
    content {
      content  = try(library_requirement.value.content, null)
      filename = try(library_requirement.value.filename, null)
    }
  }
  session_level_packages_enabled = try(var.settings.session_level_packages_enabled, null)
  dynamic "spark_config" {
    for_each = try(var.settings.spark_config, null) != null ? [var.settings.spark_config] : []
    content {
      content  = try(spark_config.value.content, null)
      filename = try(spark_config.value.filename, null)
    }
  }
  spark_log_folder    = try(var.settings.spark_log_folder, null)
  spark_events_folder = try(var.settings.spark_events_folder, null)
  spark_version       = try(var.settings.spark_version, null)
  tags                = local.tags
}