keyvault_access_policies = {
  tde_primary = {
    # Key of the keyvault created in the sqlmi1 tfstate.
    sqlmi2 = {
      keyvault_lz_key      = "sqlmi1"
      managed_identity_key = "mi2"
      key_permissions      = ["Get", "UnwrapKey", "WrapKey"]
    }
  }

}