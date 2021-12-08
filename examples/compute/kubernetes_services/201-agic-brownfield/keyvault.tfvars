keyvaults = {

  certificates = {
    name = "kvcert8373746a01"
    resource_group = {
      # lz_key = ""
      key = "aks_re1"
    }

    sku_name                 = "premium"
    soft_delete_enabled      = true
    purge_protection_enabled = false # set to true in production

    creation_policies = {
      logged_in_user = { # Set the object_id of the pripeline the following permissions
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
      }
    }
  }

}

keyvault_access_policies = {
  certificates = {
    agw_keyvault_certs = {
      managed_identity_key    = "aks_usermsi"
      certificate_permissions = ["Get"]
      secret_permissions      = ["Get"]
    }
  }
}