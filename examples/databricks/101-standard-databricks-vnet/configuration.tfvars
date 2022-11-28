#
# Global settings
#
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

#
# Resource groups to be created
#
resource_groups = {
  databricks_re1 = {
    name   = "databricks-re1"
    region = "region1"
  }
}

#
# Databricks workspace settings
#
databricks_workspaces = {
  sales_workspaces = {
    name               = "sales_workspace"
    resource_group_key = "databricks_re1"
    sku                = "standard"
    custom_parameters = {
      no_public_ip       = false
      public_subnet_key  = "databricks_public"
      private_subnet_key = "databricks_private"
      vnet_key           = "vnet_region1"
    }
  }
}

#
# Virtual network for Databricks resources
#
vnets = {
  vnet_region1 = {
    resource_group_key = "databricks_re1"
    vnet = {
      name          = "databricks"
      address_space = ["10.100.100.0/24"]
    }
    subnets = {
      databricks_public = {
        nsg_key = "databricks_public"
        name    = "databricks-public"
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
      databricks_private = {
        name    = "databricks-private"
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

#
# Definition of the security groups for the virtual subnets
#
network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  databricks_private = {
    version            = 1
    resource_group_key = "databricks_re1"
    name               = "databricks-private"

    # diagnostic_profiles = {
    #   nsg = {
    #     definition_key   = "network_security_group"
    #     destination_type = "storage"
    #     destination_key  = "all_regions"
    #   }
    # }
  }

  databricks_public = {
    version            = 1
    resource_group_key = "databricks_re1"
    name               = "databricks-public"

    # diagnostic_profiles = {
    #   nsg = {
    #     definition_key   = "network_security_group"
    #     destination_type = "storage"
    #     destination_key  = "all_regions"
    #   }
    #   operations = {
    #     name             = "operations"
    #     definition_key   = "network_security_group"
    #     destination_type = "log_analytics"
    #     destination_key  = "central_logs"
    #   }
    # }

    nsg = [
      {
        name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-control-plane-to-worker-proxy"
        description                = "Required for Databricks control plane communication with worker nodes."
        priority                   = "102"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "5557"
        source_address_prefix      = "AzureDatabricks"
        destination_address_prefix = "*"
      },
      {
        name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-control-plane-to-worker-ssh"
        description                = "Required for Databricks control plane management of worker nodes."
        priority                   = "101"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "AzureDatabricks"
        destination_address_prefix = "*"
      },
      {
        name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-eventhub"
        description                = "Required for worker communication with Azure Eventhub services."
        priority                   = "104"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "9093"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "EventHub"
      },
      {
        name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-worker-inbound"
        description                = "Required for worker nodes communication within a cluster."
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-worker-outbound"
        description                = "Required for worker nodes communication within a cluster."
        priority                   = "103"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-sql"
        description                = "Required for workers communication with Azure SQL services."
        priority                   = "101"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "3306"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "Sql"
      },
      {
        name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-storage"
        description                = "Required for workers communication with Azure Storage services."
        priority                   = "102"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "Storage"
      },
      {
        name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-databricks-webapp"
        description                = "Required for workers communication with Databricks Webapp."
        priority                   = "100"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "AzureDatabricks"
      },
    ]
  }

}