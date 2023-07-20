keyvaults = {
  secrets = {
    name                          = "secrets"
    resource_group_key            = "my_rg"
    sku_name                      = "premium"
    purge_protection_enabled      = false
    enable_rbac_authorization     = true
    public_network_access_enabled = false

    private_endpoints = {
      secrets = {
        name               = "secrets"
        resource_group_key = "my_rg"
        vnet_key           = "vnet_existing"
        subnet_key         = "private_endpoints"
        private_service_connection = {
          name                 = "secrets"
          is_manual_connection = false
          subresource_names    = ["vault"]
        }
        # private_dns = {
        #   zone_group_name = "default"
        #   keys            = ["privatelink.vaultcore.azure.net"]
        # }
      }
    }
  }
}