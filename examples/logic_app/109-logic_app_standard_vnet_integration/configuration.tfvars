global_settings = {
  default_region = "region1"
  regions = {
    region1 = "uksouth"
  }
}

resource_groups = {
  rg1 = { # Provisioned by platform team @ level 3 for your shared resorces
    name = "rg-logic-app"
  }
}

storage_accounts = {
  sa1 = {
    name                     = "staccexample"
    resource_group_key       = "rg1"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

app_service_plans = {
  asp1 = {
    name               = "appserviceplan1"
    resource_group_key = "rg1"
    kind               = "elastic"

    sku = {
      tier = "WorkflowStandard"
      size = "WS1"
    }
  }
}

logic_app_standard = {
  las1 = {
    name                 = "logicapp1"
    resource_group_key   = "rg1"
    app_service_plan_key = "asp1"
    storage_account_key  = "sa1"

    # Required for virtual network integration
    vnet_integration = {
      vnet_key   = "vnet1"
      subnet_key = "subnet1"
      # subnet_id = ""
    }

    app_settings = {
      "FUNCTIONS_WORKER_RUNTIME"     = "node",
      "WEBSITE_NODE_DEFAULT_VERSION" = "~14",
    }

  }
}

vnets = {
  vnet1 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "vnet"
      address_space = ["10.0.0.0/16"]
    }

    specialsubnets = {}

    subnets = {
      subnet1 = {
        name = "subnet"
        cidr = ["10.0.0.0/24"]
        delegation = {
          name               = "functions"
          service_delegation = "Microsoft.Web/serverFarms"
          actions            = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }

  }
}