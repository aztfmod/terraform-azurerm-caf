global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}


resource_groups = {
  rg1 = {
    name   = "example-sqldb"
    region = "region1"
  }
}

managed_identities = {
  job_agent = {
    name               = "example_db_job"
    resource_group_key = "rg1"
  }
}


mssql_servers = {
  mssqlserver1 = {
    name                          = "example-mssqlserver"
    region                        = "region1"
    resource_group_key            = "rg1"
    version                       = "12.0"
    administrator_login           = "sqluseradmin"
    keyvault_key                  = "kv1"
    connection_policy             = "Default"
    public_network_access_enabled = true
  }
}

mssql_databases = {

  mssql_db1 = {
    name               = "exampledb1"
    resource_group_key = "rg1"
    mssql_server_key   = "mssqlserver1"
    license_type       = "LicenseIncluded"
    max_size_gb        = 4
    sku_name           = "BC_Gen5_2"

    job = {
      name = "job1"
      sku  = "JA200"

      identity = {
        managed_identities = {
          msi1 = {
            key = "job_agent"
          }
        }
      }

      jobs = {
        examplejob1 = {
          name        = "examplejob1"
          description = "Test description"
          schedule = {
            enabled   = true
            startTime = "2024-04-16T23:00:00Z"
            endTime   = "9999-12-31T11:59:59Z"
            interval  = "P1D"
            type      = "Once"
          }
          steps = {
            step1 = {
              name = "step-example1"
              action = {
                source = "Inline"
                type   = "TSql"
                value  = "---SQL QUERY---"
              }
              stepId = 1
              executionOptions = {
                initialRetryIntervalSeconds    = 60
                maximumRetryIntervalSeconds    = 60
                retryAttempts                  = 60
                retryIntervalBackoffMultiplier = 60
                timeoutSeconds                 = 60
              }
            }
          }
          targetgroups = {
            targetgroup1 = {
              name = "tg1"
              members = {
                membershipType = "Include"
              }
            }
          }
        }
      }
    }

  }
}

keyvaults = {
  kv1 = {
    name               = "examplekv"
    resource_group_key = "rg1"
    sku_name           = "standard"

    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}
