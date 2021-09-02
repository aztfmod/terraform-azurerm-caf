azurerm_redis_caches = {
  sales_rc1 = {
    region             = "region1"
    resource_group_key = "rg1"
    redis = {
      name                          = "sales-rc1"
      capacity                      = 0
      family                        = "C"
      sku_name                      = "Basic"
      public_network_access_enabled = false
    }
  }
}
