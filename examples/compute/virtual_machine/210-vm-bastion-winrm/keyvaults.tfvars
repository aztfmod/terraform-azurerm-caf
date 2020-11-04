keyvaults = {
  ssh_keys = {
    name               = "vmsecrets"
    resource_group_key = "vm_region1"
    sku_name           = "standard"

    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

