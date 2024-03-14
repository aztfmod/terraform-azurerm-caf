keyvaults = {
  certificates = {
    name               = "certs"
    resource_group_key = "rg_region1"
    sku_name           = "standard"

    enabled_for_deployment = true

    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

keyvault_access_policies = {
  certificates = {
    apgw_keyvault_secrets = {
      managed_identity_key    = "apgw_keyvault_secrets"
      certificate_permissions = ["Get"]
      secret_permissions      = ["Get"]
    }
  }
}