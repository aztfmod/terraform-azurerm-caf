module "caf" {
  source = "../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups

  database = {
    azurerm_redis_caches  = var.azurerm_redis_caches
  }
}
  
