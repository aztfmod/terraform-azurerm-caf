keyvaults = {
  stg_byok = {
    name               = "vmsecrets"
    resource_group_key = "test"
    sku_name           = "standard"

    purge_protection_enabled = true
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  stg_byok = {
    stg = {
      storage_account_key = "sa1"
      key_permissions     = ["get", "create", "list", "restore", "recover", "unwrapkey", "wrapkey", "purge", "encrypt", "decrypt", "sign", "verify"]
      secret_permissions  = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    diastg = {
      diagnostic_storage_account_key = "dsa1"
      key_permissions                = ["get", "create", "list", "restore", "recover", "unwrapkey", "wrapkey", "purge", "encrypt", "decrypt", "sign", "verify"]
      secret_permissions             = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    logged_in_user = {
      key_permissions    = ["get", "create", "delete", "list", "restore", "recover", "unwrapkey", "wrapkey", "purge", "encrypt", "decrypt", "sign", "verify"]
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }
}

keyvault_keys = {
  byok = {
    name         = "storage"
    keyvault_key = "stg_byok"
    key_type     = "RSA"
    key_size     = 2048
    key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  }
  diabyok = {
    name         = "diagnosticstorage"
    keyvault_key = "stg_byok"
    key_type     = "RSA"
    key_size     = 2048
    key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  }
}