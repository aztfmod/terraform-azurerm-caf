# Approximative time to
#  - deploy: 25 mins to 30 mins
#  - destroy: 5 mins
#
# rover -lz /tf/caf/solutions/ -var-file /tf/caf/solutions/examples/redis_cache/redis-std.tfvars -a apply

global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  redis_region1 = {
    name   = "redis-std-rg"
    region = "region1"
  }
}

# vnet integration only allowed starting on Premium tier
# this deploys smallest cluster possible

azurerm_redis_caches = {
  r1 = {
    resource_group_key = "redis_region1"
    redis = {
      name                          = "redis-std-1"
      capacity                      = 1
      family                        = "P"
      sku_name                      = "Premium"
      shard_count                   = 1
      public_network_access_enabled = false

      redis_configuration = {
        rdb_backup_enabled = false
      }
    }
    tags = {
      test = "AK1"
    }
  }
}

