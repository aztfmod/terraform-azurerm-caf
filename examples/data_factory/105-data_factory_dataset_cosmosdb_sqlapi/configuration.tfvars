global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
  }
}
resource_groups = {
  rg1 = {
    name   = "databricks-re1"
    region = "region1"
  }
}
data_factory = {
  df1 = {
    name = "example"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
  }
}

cosmos_dbs = {
  cosmosdb_account_re1 = {
    name                      = "cosmosdb-ex101"
    resource_group_key        = "rg1"
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
  }
}

data_factory_linked_service_cosmosdb = {
  dflscdb1 = {
    name = "dflscdb1example"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
    data_factory = {
      key = "df1"
      #lz_key = ""
      #name = ""
    }
    cosmosdb_account = {
      key = "cosmosdb_account_re1"
      #lz_key = ""
      #endpoint = ""
      #account_key = ""
      database = "foo"
    }
    #connection_string = ""

  }
}
data_factory_dataset_cosmosdb_sqlapi = {
  dfdab1 = {
    name = "dfdab1example"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
    data_factory = {
      key = "df1"
      #lz_key = ""
      #name = ""
    }
    linked_service = {
      key = "dflscdb1"
      #lz_key = ""
      #name = ""
    }
    collection_name = "bar"
  }
}

