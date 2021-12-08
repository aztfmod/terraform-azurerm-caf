network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  databricks_private = {
    version            = 1
    resource_group_key = "reuse"
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
    resource_group_key = "reuse"
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