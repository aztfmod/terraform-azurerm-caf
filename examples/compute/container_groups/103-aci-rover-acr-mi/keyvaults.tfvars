keyvaults = {
  level0 = {
    name               = "level0"
    resource_group_key = "rg1"
    sku_name           = "standard"

    enabled_for_deployment = true

    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      msi_level0 = {
        managed_identity_key = "level0"
        secret_permissions   = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

dynamic_keyvault_secrets = {
  level0 = {
    agent = {
      secret_name = "azdo-pat-agent"
      value       = "replace with Azure DevOps PAT"
    }
  }
}