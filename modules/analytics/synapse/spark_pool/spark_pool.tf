resource "azurecaf_name" "sparkpool" {
  name          = var.settings.name
  resource_type = "azurerm_synapse_spark_pool"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_synapse_spark_pool" "spark_pool" {
  name                 = azurecaf_name.sparkpool.result
  synapse_workspace_id = var.synapse_workspace_id
  node_size_family     = var.settings.node_size_family
  node_size            = var.settings.node_size

  auto_scale {
    max_node_count = var.settings.auto_scale.max_node_count
    min_node_count = var.settings.auto_scale.min_node_count
  }

  auto_pause {
    delay_in_minutes = var.settings.auto_pause.delay_in_minutes
  }

  tags = local.tags
}

