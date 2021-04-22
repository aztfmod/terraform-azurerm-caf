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
    name                      = "gremlin"
    resource_group_key        = "cosmosdb_region1"
    offer_type                = "Standard"
    kind                      = "GlobalDocumentDB"
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

      # failover location
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
      "EnableGremlin",
      #"EnableServerless"
    ]

    gremlin_databases = {
      database_1 = {
        name       = "cosmos-gremlin-exdb"
        throughput = 400
        # autoscale_settings = {
        #   max_throughput = 4000
        # }
        graphs = {
          graph_1 = {
            name               = "cosmos-gremlin-exgph"
            partition_key_path = "/user_id"

            index_policies = {
              index_policy_1 = {
                automatic      = true
                indexing_mode  = "Consistent"
                included_paths = ["/*"]
                excluded_paths = ["/\"_etag\"/?"]
              }
            }

            conflict_resolution_policies = {
              cr_policy_1 = {
                mode                     = "LastWriterWins"
                conflict_resolution_path = "/_ts"
              }
            }

            unique_keys = {
              unique_key_1 = {
                paths = ["/user_id"]
              }
            }
          }
        }
      }
    }
  }
}
