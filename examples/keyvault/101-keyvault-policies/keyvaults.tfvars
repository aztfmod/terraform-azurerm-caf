keyvaults = {

  #
  # Keyvault with service endpoint enabled
  #
  kv_rg1 = {
    name               = "secrets"
    resource_group_key = "kv_region1"
    sku_name           = "standard"

    # Make sure you set a creation policy.
    creation_policies = {
      logged_in_user = {
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
        certificate_permissions = ["managecontacts", "manageissuers"]
      }
    }

    network = {
      bypass         = "AzureServices"
      default_action = "Deny"
      ip_rules       = ["12.12.12.12/32"]
      subnets = {
        subnet1 = {
          vnet_key   = "vnet_security"
          subnet_key = "keyvault_endpoints"
        }
        #add multiple subnets by extending this block. You can reference remote subnets by using subnet_id
        #subnet2 = {
        #subnet_id = "/subscriptions/*******/resourceGroups/*******/providers/Microsoft.Network/virtualNetworks/vnet-some-remote-vnet/subnets/snet-remote-subnet"
        # }
      }
    }

  }

  #
  # Keyvault with private endpoint enabled
  # Firewall enabled to only authorize customer's outbound ip addresses
  #
  kv02_rg1 = {
    name               = "certificates"
    resource_group_key = "kv_region1"
    sku_name           = "premium"

    # Make sure you set a creation policy.
    creation_policies = {
      logged_in_user = {
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
        certificate_permissions = ["managecontacts", "manageissuers"]
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
