global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
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
    automatic_failover_enabled = "true"

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
    free_tier_enabled = false
    ip_range_filter  = ["116.88.85.63", "116.88.85.64"]
    #capabilities              = ["EnableTable"]
    multiple_write_locations_enabled = false
    tags = {
      "project" = "EDH"
    }

    # [optional] - Other DB API supoorted - MongoDB, Table, Gramlin GraphDB

  }
}


cosmosdb_sql_databases = {
  databases_re1 = {
    name       = "cosmos-sql-exdb"
    throughput = 400
    cosmosdb_account = {
      key = "cosmosdb_account_re1"
      # lz_key = "" #for remote lz composition
      # name = "bylc-cosmos-cosmosdb-ex101" #for literals
      # rg_name = "bylc-rg-cosmosdb" #for literals
      # location = "eastus2" #for literals
    }
    containers = {
      container_re1 = {
        name               = "container-ex101"
        partition_key_paths = ["/definition/id"]
        throughput         = 400
        unique_key = {
          paths = ["/definition/idlong", "/definition/idshort"]
        }
      }
    }
  }
}