global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  logicapp = {
    name   = "logicapp-private"
    region = "region1"
  }
  spoke = {
    name   = "spoke"
    region = "region1"
  }
}

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp1 = {
    resource_group_key = "logicapp"
    name               = "asp-simple"

    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
}

logic_app_standard = {
  l1 = {
    name               = "logicapp-private"
    resource_group_key = "logicapp"
    region             = "region1"

    app_service_plan_key = "asp1"
    storage_account_key  = "sa1"

    settings = {
      vnet_key   = "spoke"
      subnet_key = "app"
      #subnet_id = "/subscriptions/97958dac-xxxx-xxxx-xxxx-9f436fa73bd4/resourceGroups/jana-rg-spoke/providers/Microsoft.Network/virtualNetworks/jana-vnet-spoke/subnets/jana-snet-app"
      enabled = true
    }
  }
}

storage_accounts = {
  sa1 = {
    name               = "logicapp-sa1"
    resource_group_key = "logicapp"
    region             = "region1"

    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"

    containers = {
      dev = {
        name = "random"
      }
    }

  }
}

vnets = {
  spoke = {
    resource_group_key = "spoke"
    region             = "region1"
    vnet = {
      name          = "spoke"
      address_space = ["10.1.0.0/24"]
    }
    specialsubnets = {}
    subnets = {
      app = {
        name = "app"
        cidr = ["10.1.0.0/28"]
        delegation = {
          name               = "functions"
          service_delegation = "Microsoft.Web/serverFarms"
          actions            = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }

  }

}

network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {
  }
}
