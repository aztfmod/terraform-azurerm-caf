keyvaults = {
  agents = {
    name                      = "agents"
    resource_group_key        = "agents"
    sku_name                  = "premium"
    purge_protection_enabled  = false
    enable_rbac_authorization = true

    creation_policies = {
      gitops = {
        managed_identity_key = "gitops"
        secret_permissions   = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
    # network = {
    #   default_action = "Deny"
    #   bypass         = "AzureServices"
    # }
    private_endpoints = {
      agents = {
        name               = "agents"
        resource_group_key = "agents"
        subnet_key         = "agents"
        private_service_connection = {
          name                 = "agents"
          is_manual_connection = false
          subresource_names    = ["vault"]
        }
        private_dns = {
          zone_group_name = "default"
          keys            = ["privatelink.vaultcore.azure.net"]
        }
      }
    }
  }
}