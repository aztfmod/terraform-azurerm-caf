global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
    region2 = "australiacentral"
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
    name                      = "cosmosdb-ex101"
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
        location          = "francecentral"
        failover_priority = 1
      }
    }

    # Optional
    enable_free_tier = false
    ip_range_filter  = "116.88.85.63,116.88.85.64"
    #capabilities              = ["EnableTable"]
    enable_multiple_write_locations = false
    tags = {
      "project" = "EDH"
    }

    # [optional] - Other DB API supoorted - MongoDB, Table, Gramlin GraphDB
    sql_databases = {
      databases_re1 = {
        name       = "cosmos-sql-exdb"
        throughput = 400
        containers = {
          container_re1 = {
            name               = "container-ex101"
            partition_key_path = "/definition/id"
            throughput         = 400
            unique_key = {
              path = ["/definition/idlong", "/definition/idshort"]
            }
          }
        }
      }
    }
  }
}


