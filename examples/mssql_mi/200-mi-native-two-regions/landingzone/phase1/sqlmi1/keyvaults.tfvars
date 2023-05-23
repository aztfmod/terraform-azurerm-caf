
keyvaults = {
  sqlmi_rg1 = {
    name               = "sqlmirg1"
    resource_group_key = "sqlmi_region1"
    sku_name           = "standard"

    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }

  tde_primary = {
    name                       = "mi-tde-primary"
    resource_group_key         = "sqlmi_region1"
    sku_name                   = "premium"
    purge_protection_enabled   = true
    soft_delete_retention_days = 90
    creation_policies = {
      logged_in_user = {
        key_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Purge", "GetRotationPolicy", "SetRotationPolicy"]
      }
    }
  }

}
keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  tde_primary = {
    sqlmi1 = {
      managed_identity_key = "mi1"
      key_permissions      = ["Get", "UnwrapKey", "WrapKey"]
    }
  }

}
