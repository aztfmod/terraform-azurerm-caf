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

managed_identities = {
  demo1 = {
    name               = "demo1"
    resource_group_key = "cosmosdb_region1"
  }
}

database = {
  cosmos_dbs = {
    cosmosdb_account_re1 = {
      name                      = "cosmosdb"
      resource_group_key        = "cosmosdb_region1"
      offer_type                = "Standard"
      kind                      = "GlobalDocumentDB"
      enable_automatic_failover = "true"

      consistency_policy = {
        consistency_level       = "BoundedStaleness"
        max_interval_in_seconds = "300"
        max_staleness_prefix    = "100000"
      }

      geo_locations = {
        primary_geo_location = {
          prefix            = "customid-101"
          region            = "region1"
          zone_redundant    = false
          failover_priority = 0
        }
      }

      sql_databases = {
        databases_re1 = {
          name       = "cosmos-sql-exdb"
          throughput = 400
          resource_group = {
            key = "cosmosdb_region1"
          }
          cosmosdb_account = {
            key = "cosmosdb_account_re1"
          }
          containers = {
            container1 = {
              name               = "container-ex101"
              partition_key_path = "/partitionKeyPath"

              autoscale_settings = {
                max_throughput = 4000
              }
            }
          }
        }
      }
    }
  }

  cosmosdb_role_definitions = {
    "Cosmos DB account scoped role" = {
      name = "Cosmos DB account scoped role"
      resource_group = {
        key = "cosmosdb_region1"
      }
      account = {
        key = "cosmosdb_account_re1"
      }
      assignable_scopes = {
        cosmos_dbs = [
          {
            key = "cosmosdb_account_re1"
          }
        ]
      }
      permissions = {
        data_actions = [
          "Microsoft.DocumentDB/databaseAccounts/readMetadata",
          "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*",
          "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*"
        ]
      }
    }

    "Cosmos DB SQL database scoped role" = {
      name = "Cosmos DB SQL database scoped role"
      resource_group = {
        key = "cosmosdb_region1"
      }
      account = {
        key = "cosmosdb_account_re1"
      }
      assignable_scopes = {
        cosmosdb_sql_databases = [
          {
            key = "databases_re1"
          }
        ]
      }
      permissions = {
        data_actions = [
          "Microsoft.DocumentDB/databaseAccounts/readMetadata",
          "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*",
          "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*"
        ]
      }
    }

    "Cosmos DB SQL container role" = {
      name = "Cosmos DB SQL container role"
      resource_group = {
        key = "cosmosdb_region1"
      }
      account = {
        key = "cosmosdb_account_re1"
      }
      assignable_scopes = {
        cosmosdb_sql_containers = [
          {
            key = "container1"
            sql_database = {
              #lz_key = ""
              key = "databases_re1"
            }
          }
        ]
      }
      permissions = {
        data_actions = [
          "Microsoft.DocumentDB/databaseAccounts/readMetadata",
          "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*",
          "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*"
        ]
      }
    }
  }

  cosmosdb_role_mapping = {

    built_in_role_mapping = {
      cosmosdb_accounts = {
        cosmosdb_account_re1 = {
          # lz_key = ""
          "Cosmos DB Built-in Data Reader" = {
            managed_identities = {
              # lz_key = ""
              keys               = ["demo1"]
              resource_group_key = "cosmosdb_region1"
            }
          }
        }
      }
    }

    custom_role_mapping = {
      cosmosdb_accounts = {
        cosmosdb_account_re1 = {
          # lz_key = ""
          "Cosmos DB account scoped role" = {
            managed_identities = {
              # lz_key = ""
              keys               = ["demo1"]
              resource_group_key = "cosmosdb_region1"
            }
          }
        }
      }

      cosmosdb_sql_databases = {
        databases_re1 = {
          # lz_key = ""
          account_key = "cosmosdb_account_re1"
          "Cosmos DB SQL database scoped role" = {
            managed_identities = {
              # lz_key = ""
              keys               = ["demo1"]
              resource_group_key = "cosmosdb_region1"
            }
          }
        }
      }

      cosmosdb_sql_containers = {
        container1 = {
          account_key  = "cosmosdb_account_re1"
          database_key = "databases_re1"
          # lz_key = ""
          "Cosmos DB SQL container role" = {
            managed_identities = {
              # lz_key = ""
              keys               = ["demo1"]
              resource_group_key = "cosmosdb_region1"
            }
          }
        }
      }
    }
  }
}
