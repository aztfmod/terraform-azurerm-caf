role_mapping = {
  built_in_role_mapping = {
    keyvaults = {
      "Key Vault Secrets User" = {
          managed_identities = {
            keys = ["appgw_keyvault_certs"]
          }
        }
    }
  }  
}
