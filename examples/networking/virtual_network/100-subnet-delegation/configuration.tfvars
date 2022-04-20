global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  vnet_re1 = {
    name   = "databricks-networking-re1"
    region = "region1"
  }
}

vnets = {
  vnet_spoke_data_re1 = {
    resource_group_key = "vnet_re1"
    vnet = {
      name          = "databricks"
      address_space = ["10.150.100.0/24"]
    }
    #specialsubnets = {}
    subnets = {
      databricks_public = {
        name = "databricks-public"
        cidr = ["10.150.100.64/26"]
        delegation = {
          name               = "databricks"
          service_delegation = "Microsoft.Databricks/workspaces"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
            "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
            "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
          ]
        }
      }
      databricks_private = {
        name = "databricks-private"
        cidr = ["10.150.100.128/26"]
        delegation = {
          name               = "databricks"
          service_delegation = "Microsoft.Databricks/workspaces"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
            "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
            "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
          ]
        }
      }
    }

  }
}

