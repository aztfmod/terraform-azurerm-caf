global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  kv_region1 = {
    name   = "keyvault-rg1"
    region = "region1"
  }
}

keyvaults = {

  #
  # Keyvault with private endpoint enabled and configured with two static ips
  #
  kv01_rg1 = {
    name               = "certificates"
    resource_group_key = "kv_region1"
    sku_name           = "premium"

    creation_policies = {
      logged_in_user = {
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
        certificate_permissions = ["ManageContacts", "ManageIssuers"]
      }
    }

    network = {
      bypass         = "AzureServices"
      default_action = "Deny"
    }

    private_endpoints = {
      # Require enforce_private_link_endpoint_network_policies set to true on the subnet
      private-link1 = {
        name               = "keyvault-certificates"
        vnet_key           = "vnet_security"
        subnet_key         = "private_link"
        resource_group_key = "kv_region1"
        # if the private_endpoint must be deployed in a remote resource group
        # resource_group = {
        #   lz_key = ""
        #   key    = ""
        # }

        private_service_connection = {
          name                 = "keyvault-certificates"
          is_manual_connection = false
          subresource_names    = ["vault"]
        }

        ip_configurations = {
          static1 = {
            name               = "kv01_rg1-name1"
            private_ip_address = "10.150.100.140"
            subresource_name   = "vault"
            member_name        = "default"
          }
          static2 = {
            name               = "kv01_rg1-name2"
            private_ip_address = "10.150.100.150"
            subresource_name   = "vault"
            member_name        = "default2"
          }
        }

        # private_dns = {
        #   lz_key = ""
        #   keys   = ["vaultcore"]
        # }
      }
    }
  }
}

vnets = {
  vnet_security = {
    resource_group_key = "kv_region1"
    vnet = {
      name          = "keyvaults"
      address_space = ["10.150.100.0/24"]
    }
    subnets = {
      keyvault_endpoints = {
        name              = "keyvault"
        cidr              = ["10.150.100.64/26"]
        service_endpoints = ["Microsoft.KeyVault"]
      }
      private_link = {
        name                                           = "private-links"
        cidr                                           = ["10.150.100.128/26"]
        enforce_private_link_endpoint_network_policies = true
      }
    }
  }
}
