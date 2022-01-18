vnets = {
  vnet = {
    resource_group_key = "reuse"
    vnet = {
      name          = "databricks"
      address_space = ["10.100.100.0/24"]
    }
    subnets = {
      egress = {
        nsg_key = "databricks_public"
        name    = "public"
        cidr    = ["10.100.100.64/26"]
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
      private = {
        name    = "private"
        cidr    = ["10.100.100.128/26"]
        nsg_key = "databricks_private"
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