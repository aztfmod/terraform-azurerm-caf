# Pre-requisites: requires eventhub as the central logging to be deployed in lower levels prior to this

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

diagnostic_event_hub_namespaces = {
  event_hub_namespace1 = {
    name               = "security_operation_logs"
    resource_group_key = "rg1"
    sku                = "Standard"
    region             = "region1"
  }
}

diagnostics_destinations = {
  event_hub_namespaces = {
    central_logs_example = {
      event_hub_namespace_key = "event_hub_namespace1"
    }
  }
}

mssql_servers = {
  mssql_server1 = {
    name                          = "js-mssql-server"
    region                        = "region1"
    resource_group_key            = "rg1"
    version                       = "12.0"
    administrator_login           = "sqladmin"
    keyvault_key                  = "kv1"
    connection_policy             = "Default"
    public_network_access_enabled = false
    minimum_tls_version           = "1.2"
  }
}

mssql_databases = {
  mssql_db1 = {
    name               = "exampledb1"
    resource_group_key = "rg1"
    mssql_server_key   = "mssql_server1"
    license_type       = "LicenseIncluded"
    max_size_gb        = 4
    sku_name           = "BC_Gen5_2"


    diagnostic_profiles = {
      app_service = {
        definition_key   = "mssql_db"
        destination_type = "event_hub"
        destination_key  = "central_logs_example" # Needs to be deployed in launchpad first
      }
    }

  }
}


diagnostics_definition = {
  mssql_db = {
    name = "operational_logs_and_metrics"

    categories = {
      log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AutomaticTuning", true, false, 0],
        ["Blocks", true, false, 0],
        ["DatabaseWaitStatistics", true, false, 0],
        ["Deadlocks", true, false, 0],
        ["DevOpsOperationsAudit", true, false, 0],
        ["QueryStoreRuntimeStatistics", true, false, 0],
        ["QueryStoreWaitStatistics", true, false, 0],
        ["SQLInsights", true, false, 0],
        ["SQLSecurityAuditEvents", true, false, 0],
        ["Timeouts", true, false, 0],
        ["Errors", true, false, 0],

      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["Basic", true, false, 0],
        ["InstanceAndAppAdvanced", true, false, 0],
        ["WorkloadManagement", true, false, 0],
      ]
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
