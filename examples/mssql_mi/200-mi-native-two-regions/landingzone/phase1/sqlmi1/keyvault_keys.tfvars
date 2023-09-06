keyvault_keys = {
  tde_primary1 = {
    keyvault_key = "tde_primary"

    name     = "TDE-KEY"
    key_type = "RSA"
    key_opts = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]
    key_size = 2048
    rotation_policy = {
      automatic = {
        time_before_expiry = "P8D"
      }

      expire_after         = "P90D"
      notify_before_expiry = "P29D"
    }
  }
}

