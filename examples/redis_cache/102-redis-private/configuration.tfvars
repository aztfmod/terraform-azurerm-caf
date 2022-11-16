# Approximative time to
#  - deploy: 25 mins to 30 mins
#  - destroy: 5 mins
#
# rover -lz /tf/caf/solutions/ -var-folder /tf/caf/solutions/examples/redis_cache/example -a apply

global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  redis_region1 = {
    name   = "redis-rg"
    region = "region1"
  }
}

azurerm_redis_caches = {
  r1 = {
    resource_group_key = "redis_region1"

    vnet_key   = "vnet1"
    subnet_key = "redis"

    redis = {
      name                          = "redis-1"
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
      test = "private"
    }
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "redis_region1"
    vnet = {
      name          = "test-vnet"
      address_space = ["10.1.0.0/24"]
    }
    specialsubnets = {}
    subnets = {
      redis = {
        name = "redis"
        cidr = ["10.1.0.0/28"]
      }
    }
  }
}

network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {}
}

