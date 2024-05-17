resource_groups = {
  la_test = {
    name = "rg-logic-app"
  }
}

vnets = {
  vnet = {
    resource_group_key = "la_test"
    vnet = {
      name          = "la-vnet"
      address_space = ["10.0.0.0/24"]
    }
    subnets = {
      private_endpoints_sn = {
        name                                           = "private-endpoints"
        cidr                                           = ["10.0.0.32/27"]
        enforce_private_link_endpoint_network_policies = false
        enforce_private_link_service_network_policies  = false
      }
      la_test_subnet = {
        name                                           = "logic_apps"
        cidr                                           = ["10.0.0.64/27"]
        delegation = {
          name               = "functions"
          service_delegation = "Microsoft.Web/serverFarms"
          actions            = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
  }
}

storage_accounts = {
  sa1 = {
    name                     = "la_sa"
    resource_group_key       = "la_test"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

managed_identities = {
  logicapp_msi = {
    name               = "logicapp1-msi"
    resource_group_key = "la_test"
  }
}


app_service_plans = {
  asp1 = {
    name               = "appserviceplan1"
    resource_group_key = "la_test"
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
    resource_group_key   = "la_test"
    app_service_plan_key = "asp1"
    storage_account_key  = "sa1"
    version              = "~4"
    # Required for virtual network integration
    vnet_integration = {
      vnet_key   = "vnet"
      subnet_key = "la_test_subnet"
      # lz_key     = ""
      # subnet_id = ""
    }
    identity = {
      type = "UserAssigned" #SystemAssigned
      key = "logicapp_msi"
      #lz_key = ""
      #identity_ids = ["/subscriptions/sub-id/resourceGroups/rg-id/providers/Microsoft.ManagedIdentity/userAssignedIdentities/msi-id"]
    }
    private_endpoints = {
      pe_la = {
        private_service_connection = {
          name = "pe_la_sc"
          subresource_names = ["sites"]
        }
        name = "pe_la"
        vnet_key   = "vnet"
        subnet_key = "private_endpoints_sn"
        #lz_key     = ""
      }
    }
  }
}