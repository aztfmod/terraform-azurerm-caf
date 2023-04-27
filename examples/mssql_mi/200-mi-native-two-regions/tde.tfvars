keyvault_keys = {
  tde_primary1 = {
    keyvault_key = "tde_primary"
    name         = "TDE-KEY"
    key_type     = "RSA"
    key_opts     = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]
    key_size     = 2048
    rotation_policy = {
      automatic = {
        time_before_expiry = "P8D"
      }

      expire_after         = "P90D"
      notify_before_expiry = "P29D"
    }
  }
}




//set TDE  key
mssql_mi_tdes = {
  sqlmi1 = {
    version               = "v1"
    auto_rotation_enabled = true
    mi_server = {
      key = "sqlmi1"
    }
    keyvault_key = {
      key = "tde_primary1"
    }
  }
}

mssql_mi_secondary_tdes = {
  sqlmi2 = {
    version               = "v1"
    auto_rotation_enabled = true
    mi_server = {
      key = "sqlmi2"
    }
    keyvault_key = {
      key = "tde_primary1"
    }
  }
}