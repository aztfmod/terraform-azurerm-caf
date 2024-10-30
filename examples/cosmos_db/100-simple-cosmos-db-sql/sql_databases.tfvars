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
    ip_range_filter  = ["116.88.85.63","116.88.85.64"]
    #capabilities              = ["EnableTable"]
    multiple_write_locations_enabled = false
    tags = {
      "project" = "EDH"
    }

    # [optional] - Other DB API supoorted - MongoDB, Table, Gramlin GraphDB
    sql_databases = {
      databases_re1 = {
        # when set to 'true' it will append random generated integer to sql database
        # defaults to 'true'
        # add_rnd_num = true
        name       = "cosmos-sql-exdb"
        throughput = 400

        containers = {
          container1 = {
            name               = "container-ex101"
            partition_key_path = "/partitionKeyPath"

            unique_key = {
              paths = ["/uniquePath1", "/uniquePath2"]
            }

            autoscale_settings = {
              max_throughput = 4000
            }

            indexing_policy = {
              included_paths = {
                path1 = "/*"
              }

              excluded_paths = {
                path1 = "/excludedPath/?"
              }

              spatial_indexes = {
                path1 = "/spatialIndexPath1/?"
                path2 = "/spatialIndexPath2/?"
              }

              composite_indexes = {
                composite_index1 = {
                  index1 = {
                    path  = "/indexPath1"
                    order = "Descending"
                  }
                  index2 = {
                    path  = "/indexPath2"
                    order = "Descending"
                  }
                }

                composite_index2 = {
                  index1 = {
                    path  = "/indexPath1"
                    order = "Ascending"
                  }
                  index2 = {
                    path  = "/indexPath2"
                    order = "Ascending"
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
