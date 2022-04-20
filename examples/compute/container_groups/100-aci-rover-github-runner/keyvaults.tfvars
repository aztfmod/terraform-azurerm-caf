keyvaults = {
  secrets = {
    name               = "secrets"
    resource_group_key = "rg1"
    sku_name           = "standard"

    enabled_for_deployment = true

    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      rover = {
        managed_identity_key = "rover"
        secret_permissions   = ["Get"]
      }
    }
  }
}

