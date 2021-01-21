global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
    region2 = "westeurope"
  }
}

resource_groups = {
  cosmosdb_region1 = {
    name   = "cosmosdb"
    region = "region1"
  }
}

cosmos_dbs = {
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
        zone_redundant    = false
        failover_priority = 0
      }

      # failover location; note that Serverless accounts cannot currently have multiple regions
      failover_geo_location = {
        region            = "region2"
        zone_redundant    = false
        failover_priority = 1
      }
    }

    # optional
    enable_free_tier                = false
    ip_range_filter                 = ""
    enable_multiple_write_locations = false
    tags = {
      "project" = "EDH"
    }

    capabilities = [
      "EnableMongo",
      #"EnableServerless",
      #"DisableRateLimitingResponses"
    ]

    mongo_databases = {
      database_re1 = {
        name       = "cosmos-mongo-exdb"
        throughput = 400
        collections = {
          collection_re1 = {
            name                = "cosmos-mongo-excoll"
            shard_key           = "user_id"
            thoughput           = 400
            default_ttl_seconds = 0
            indexes = {
              index_1 = {
                keys = ["user_id"]
              }
              index_2 = {
                keys   = ["_id"]
                unique = true
              }
            }
          }
        }
      }
    }
  }
}
