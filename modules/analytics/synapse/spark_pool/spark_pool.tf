resource "azurecaf_name" "sparkpool" {
  name          = var.settings.name
  resource_type = "azurerm_synapse_spark_pool"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_spark_pool
# Tested with: AzureRM provider 2.57.0

resource "azurerm_synapse_spark_pool" "spark_pool" {
  name                 = azurecaf_name.sparkpool.result
  synapse_workspace_id = var.synapse_workspace_id
  node_size_family     = var.settings.node_size_family
  node_size            = var.settings.node_size
  node_count           = try(var.settings.node_count, null)
  spark_log_folder     = try(var.settings.spark_log_folder, "/logs")
  spark_events_folder  = try(var.settings.spark_events_folder, "/events")
  spark_version        = try(var.settings.spark_version, "2.4")

  auto_scale {
    max_node_count = var.settings.auto_scale.max_node_count
    min_node_count = var.settings.auto_scale.min_node_count
  }

  auto_pause {
    delay_in_minutes = var.settings.auto_pause.delay_in_minutes
  }

  dynamic "library_requirement" {
    for_each = try(var.settings.library_requirement, {})

    content {
      content  = var.settings.library_requirement.content
      filename = var.settings.library_requirement.filename
    }
  }

  tags = local.tags
}

