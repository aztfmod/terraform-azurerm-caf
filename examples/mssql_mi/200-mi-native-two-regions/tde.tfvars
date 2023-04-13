keyvault_keys = {
  tde_primary = {
    keyvault_key = "tde_primary"
    name         = "TDE"
    key_type     = "RSA"
    key_opts     = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]
    key_size     = 2048
    backups = {
      tde_secondary = {
        key = "tde_sqlmi2"
      }
    }
  }
}

//TDE
mssql_mi_tdes = {
  sqlmi1 = {
    version = "v1"
    mi_server = {
      key = "sqlmi1"
    }
    keyvault_key = {
      key = "tde_primary"
    }
  }
}

mssql_mi_secondary_tdes = {
  sqlmi2 = {
    version = "v1"
    mi_server = {
      key = "sqlmi2"
    }
    keyvault_key = {
      key = "tde_primary"
    }
  }
}