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
    name                      = "cosmosdbtable-ex101"
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
      "EnableTable",
      #"EnableServerless"
    ]

    tables = {
      table_re1 = {
        name       = "cosmos-table-ex1"
        throughput = 400
        # autoscale_settings = {
        #   max_throughput = 4000
        # }
      }
    }
  }
}
