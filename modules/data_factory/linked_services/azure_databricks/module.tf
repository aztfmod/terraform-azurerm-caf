resource "azurecaf_name" "dflsad" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory_linked_service_azure_databricks"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_data_factory_linked_service_azure_databricks" "dflsad" {

  name                = azurecaf_name.dflsad.result
  resource_group_name = var.resource_group_name
  data_factory_name   = var.remote_objects.data_factory.name
  access_token        = try(var.settings.access_token, null)

  dynamic "key_vault_password" {
    for_each = try(var.settings.key_vault_password, null) != null ? [var.settings.key_vault_password] : []
    content {
      linked_service_name = try(key_vault_password.value.linked_service_name, null)
      secret_name         = try(key_vault_password.value.secret_name, null)
    }
  }


  msi_work_space_resource_id = try(coalesce(
    try(var.settings.databricks_workspace.id, null),
    try(var.remote_objects.databricks_workspace.id, null)
  ), null)

  adb_domain = try(coalesce(
    try(var.settings.databricks_workspace.adb_domain, null),
    try(format("https://%s", var.remote_objects.databricks_workspace.workspace_url), null)
  ), null)

  existing_cluster_id = try(var.settings.existing_cluster_id, null)

  dynamic "instance_pool" {
    for_each = try(var.settings.instance_pool, null) != null ? [var.settings.instance_pool] : []
    content {
      instance_pool_id      = try(instance_pool.value.instance_pool_id, null)
      cluster_version       = try(instance_pool.value.cluster_version, null)
      min_number_of_workers = try(instance_pool.value.min_number_of_workers, null)
      max_number_of_workers = try(instance_pool.value.max_number_of_workers, null)
    }
  }

  dynamic "new_cluster_config" {
    for_each = try(var.settings.new_cluster_config, null) != null ? [var.settings.new_cluster_config] : []
    content {
      cluster_version             = try(new_cluster_config.value.cluster_version, null)
      node_type                   = try(new_cluster_config.value.node_type, null)
      custom_tags                 = try(new_cluster_config.value.custom_tags, null)
      driver_node_type            = try(new_cluster_config.value.driver_node_type, null)
      init_scripts                = try(new_cluster_config.value.init_scripts, null)
      log_destination             = try(new_cluster_config.value.log_destination, null)
      spark_config                = try(new_cluster_config.value.spark_config, null)
      spark_environment_variables = try(new_cluster_config.value.spark_environment_variables, null)

      min_number_of_workers = try(new_cluster_config.value.min_number_of_workers, null)
      max_number_of_workers = try(new_cluster_config.value.max_number_of_workers, null)

    }
  }


  additional_properties    = try(var.settings.additional_properties, null)
  annotations              = try(var.settings.annotations, null)
  description              = try(var.settings.description, null)
  integration_runtime_name = try(var.settings.integration_runtime_name, var.integration_runtime_name)
  parameters               = try(var.settings.parameters, null)

}
