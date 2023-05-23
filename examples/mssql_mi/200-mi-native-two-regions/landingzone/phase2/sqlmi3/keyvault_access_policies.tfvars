keyvault_access_policies = {
  tde_primary = {
    # Key of the keyvault created in the sqlmi1 tfstate.
    sqlmi3 = {
      keyvault_lz_key      = "sqlmi1"
      managed_identity_key = "mi3"
      key_permissions      = ["Get", "UnwrapKey", "WrapKey"]
    }
  }

}