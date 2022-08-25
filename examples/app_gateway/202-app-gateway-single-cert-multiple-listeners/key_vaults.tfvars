keyvaults = {
  cert_kv = {
    name               = "agw-certs"
    sku_name           = "standard"

    resource_group_key = "core_services"

    enable_rbac_authorization = true
    
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}
