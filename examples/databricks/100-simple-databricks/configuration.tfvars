#
# Global settings
#
global_settings = {
  default_region = "region1"
  prefix         = null
  regions = {
    region1 = "southeastasia"
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
        name = "databricks-public"
        cidr = ["10.100.100.64/26"]
        delegation = {
          name               = "databricks"
          service_delegation = "Microsoft.Databricks/workspaces"
        }
      }
      databricks_private = {
        name = "databricks-private"
        cidr = ["10.100.100.128/26"]
        delegation = {
          name               = "databricks"
          service_delegation = "Microsoft.Databricks/workspaces"
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
  empty_nsg = {

    # diagnostic_profiles = {
    #   nsg = {
    #     definition_key   = "network_security_group"
    #     destination_type = "storage"
    #     destination_key  = "all_regions"
    #   }
    # }
  }

  azure_bastion_nsg = {

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
        name                       = "bastion-in-allow",
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

}