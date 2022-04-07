module "spark_pool" {
  source   = "./spark_pool"
  for_each = try(var.settings.synapse_spark_pools, {})

  global_settings      = var.global_settings
  settings             = each.value
  synapse_workspace_id = azurerm_synapse_workspace.ws.id
  tags                 = local.tags
}