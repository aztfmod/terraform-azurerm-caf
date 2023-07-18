


//set TDE  key
mssql_mi_tdes = {
  sqlmi1 = {
    version               = "v1"
    auto_rotation_enabled = true
    mi_server = {
      lz_key = "sqlmi1"
      key    = "sqlmi1"
    }
    keyvault_key = {
      lz_key = "sqlmi1"
      key    = "tde_primary1"
    }
  }
}

mssql_mi_secondary_tdes = {
  sqlmi2 = {
    version               = "v1"
    auto_rotation_enabled = true
    mi_server = {
      lz_key = "sqlmi2"
      key    = "sqlmi2"
    }
    keyvault_key = {
      lz_key = "sqlmi1"
      key    = "tde_primary1"
    }
  }
}