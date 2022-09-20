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

    private_endpoints = {
      pe1 = {
        name               = "redis"
        resource_group_key = "redis_region1"
        vnet_key           = "vnet1"
        subnet_key         = "pep"
        private_service_connection = {
          name                 = "redis"
          is_manual_connection = false
          subresource_names    = ["redisCache"]
        }
        private_dns = {
          zone_group_name = "redis"
          keys            = ["redis_dns"]
        }
      }
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
      pep = {
        name = "pep"
        cidr = ["10.1.0.0/28"]
        # service_endpoints                              = ["Microsoft.Cache/Redis"]
        enforce_private_link_endpoint_network_policies = "true"
      }
    }
  }
}

network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {}
}

private_dns = {
  redis_dns = {
    name               = "privatelink.redis.cache.windows.net"
    resource_group_key = "redis_region1"
    vnet_links = {
      vnlnk1 = {
        name     = "redis"
        vnet_key = "vnet1"
      }
    }
  }

}