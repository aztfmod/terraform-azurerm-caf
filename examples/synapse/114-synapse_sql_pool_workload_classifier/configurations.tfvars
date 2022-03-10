global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-agw"
    region = "region1"
  }
}
storage_accounts = {
  sa1 = {
    name                     = "sa1"
    resource_group_key       = "rg1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
storage_data_lake_gen2_filesystem = {
  sdlg21 = {
    name = "example"
    storage_account = {
      key = "sa1"
    }
  }
}

synapse_workspace = {
  syws1 = {
    name = "example"
    resource_group = {
      key = "rg1"
    }
    location = "region1"
    storage_data_lake_gen2_filesystem = {
      key = "sdlg21"
    }
    sql_administrator_login          = "sqladminuser"
    sql_administrator_login_password = "H@Sh1CoR3!"
    tags = {
      Env = "production"
    }
  }
}
synapse_sql_pool = {
  sysp1 = {
    name = "examplesqlpool"
    synapse_workspace = {
      key = "syws1"
    }
    sku_name    = "DW100c"
    create_mode = "Default"
  }
}
synapse_sql_pool_workload_group = {
  sspwg1 = {
    name = "example"
    sql_pool = {
      id = "sysp1"
    }
    importance                         = "normal"
    max_resource_percent               = 100
    min_resource_percent               = 0
    max_resource_percent_per_request   = 3
    min_resource_percent_per_request   = 3
    query_execution_timeout_in_seconds = 0
  }
}

synapse_sql_pool_workload_classifier = {
  sspwc1 = {
    name = "example"
    workload_group = {
      key = "sspwg1"
    }
    context     = "example_context"
    end_time    = "14:00"
    importance  = "high"
    label       = "example_label"
    member_name = "dbo"
    start_time  = "12:00"
  }
}