global_settings = {
  default_region = "region1"
  regions = {
    region1 = "francecentral"
  }
}

resource_groups = {
  rg1 = {
    name   = "windowsfunapp-private"
    region = "region1"
  }
}


storage_accounts = {
  sa1 = {
    name                     = "windowsfunctionsapptestsa"
    resource_group_key       = "rg1"
    region                   = "region1"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

app_service_plans = {
  asp1 = {
    name               = "azure-windows-functions-test-service-plan"
    resource_group_key = "rg1"
    region             = "region1"
    kind               = "functionapp"

    sku = {
      tier = "Dynamic"
      size = "Y1"
    }
  }
}

windows_function_apps = {
  faaps1 = {
    name                 = "windows-test-azure-functions"
    resource_group_key   = "rg1"
    region               = "region1"
    app_service_plan_key = "asp1"
    storage_account_key  = "sa1"
    settings = {
      application_stack = {
        powershell_core_version = "7.4"
      }
      site_config = {
        ftps_state                = "Disabled" // AllAllowed, FtpsOnly and Disabled
        always_on                 = true
        http2_enabled             = true
        min_tls_version           = "1.2"
        use_32_bit_worker_process = false
        vnet_route_all_enabled    = true
      }      
    }
  }
}