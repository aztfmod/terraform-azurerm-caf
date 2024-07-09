global_settings = {
  regions = {
    region1 = "australiaeast"
    region2 = "australiacentral"
  }
}

resource_groups = {
  primary = {
    name = "sharedsvc_re1"
  }
}

# msi
managed_identities = {
  asr1 = {
    name               = "asr1"
    resource_group_key = "primary"
  }
}

recovery_vaults = {
  asr1 = {
    name               = "vault_re1"
    resource_group_key = "primary"

    region = "region1"

    replication_policies = {
      repl1 = {
        name               = "policy1"
        resource_group_key = "primary"

        recovery_point_retention_in_minutes                  = 24 * 60
        application_consistent_snapshot_frequency_in_minutes = 4 * 60
      }
    }

    backup_policies = {
      vms = {
        policy1 = {
          name                           = "VMBackupPolicy1"
          vault_key                      = "asr1"
          rg_key                         = "primary"
          timezone                       = "UTC"
          instant_restore_retention_days = 5
          backup = {
            frequency = "Daily"
            time      = "23:00"
            #if not desired daily, can pick weekdays as below:
            #weekdays  = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
          }
          retention_daily = {
            count = 10
          }
          retention_weekly = {
            count    = 42
            weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
          }
          retention_monthly = {
            count    = 7
            weekdays = ["Sunday", "Wednesday"]
            weeks    = ["First", "Last"]
          }
          retention_yearly = {
            count    = 7
            weekdays = ["Sunday"]
            weeks    = ["Last"]
            months   = ["January"]
          }
        }
      }

      fs = {
        policy1 = {
          name      = "FSBackupPolicy1"
          vault_key = "asr1"
          rg_key    = "primary"
          timezone  = "UTC"
          backup = {
            frequency = "Daily"
            time      = "23:00"
          }
          retention_daily = {
            count = 1
          }
          retention_weekly = {
            count    = 1
            weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
          }
          retention_monthly = {
            count    = 1
            weekdays = ["Sunday", "Wednesday"]
            weeks    = ["First", "Last"]
          }
          retention_yearly = {
            count    = 2
            weekdays = ["Sunday"]
            weeks    = ["Last"]
            months   = ["January"]
          }
        }
      }
    }

    encryption = {
      key_id                            = "https://myvault001.vault.azure.net/keys/asr-cmk/"
      infrastructure_encryption_enabled = true
      user_assigned_identity = {
        key = "asr1"
      }
    }

    identity = {
      # Do not use "SystemAssigned, UserAssigned", there is a bug in the provider
      type = "UserAssigned"
      managed_identities = {
        asr1 = {
          key = "asr1"
        }
      }
    }
  }
}
