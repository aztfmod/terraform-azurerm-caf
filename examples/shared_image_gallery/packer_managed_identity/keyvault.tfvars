keyvaults = {
  packer = {
    name                   = "packer"
    resource_group_key     = "sig"
    sku_name               = "standard"
    soft_delete_enabled    = true
    enabled_for_deployment = true
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}