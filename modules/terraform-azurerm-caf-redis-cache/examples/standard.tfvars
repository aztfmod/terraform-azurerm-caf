resource_groups = {
  asp_region1 = {
    name   = "redis-std-rg"
    region = "region1"
  }
}

database = {
    azurerm_redis_caches = {
        r1 = {
            redis = {
                name        = "redis-std"
                capacity    = 2
                family      = "C"
                sku_name    = "Standard"
            }
            tags = {
                test = "AK"
            }
        }
    }
}
