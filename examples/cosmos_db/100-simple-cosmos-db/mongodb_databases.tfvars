global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
    region2 = "eastasia"
  }
}

resource_groups = {
  cosmosdb_region1 = {
    name   = "cosmosdb"
    region = "region1"
  }
}

cosmosdb_account_re1 = {
    name                      = "cosmosdbmongo-ex102"
    resource_group_key        = "cosmosdb_region1"
    offer_type                = "Standard"
    kind                      = "MongoDB"
    enable_automatic_failover = "true"

    consistency_policy = {
      consistency_level       = "BoundedStaleness"
      max_interval_in_seconds = "300"
      max_staleness_prefix    = "100000"
    }
    # Primary location (Write Region)
    geo_locations = {
      primary_geo_location = {
        prefix            = "customid-101"
        region            = "region1"
        failover_priority = 0
      }
      # failover location
      # failover_geo_location = {
      #   region            = "region2"
      #   failover_priority = 1
      # }
    }

    enable_free_tier = false

    mongo_databases = {
      database_re1 = {
        name       = "cosmos-mongo-exdb"
        throughput = 400
        collections = {
          collection_re1 = {
            name                = "collection-ex101"
            shard_key           = "example_key"
            thoughput           = 400
            default_ttl_seconds = "0"
          }
        }
      }
    }
  }