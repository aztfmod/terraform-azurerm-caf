recovery_vaults = {
  asr1 = {
    name               = "vault_re1"
    resource_group_key = "primary"
    region             = "region1"
    vnet_key           = "vnet_region1"
    subnet_key         = "asr_subnet"

    soft_delete_enabled = false
    backup_policies = {
      sql = {
        policy1 = {
          name      = "SQLDataBase-Weekly"
          vault_key = "asr1"
          rg_key    = "primary"
          timezone  = "UTC"
          compression_enabled = false
          policy_type = "Full"

          backup = {
            frequency = "Weekly"
            frequency_in_minutes = "30"
            time      = "23:00"
            weekdays  = ["Monday", "Wednesday", "Friday"]
          }
          simple_retention = {
            count = 10
          }
          retention_weekly = {
            count    = 104
            weekdays  = ["Monday", "Wednesday", "Friday"]
          }
          retention_monthly = {
            count    = 60
            format_type = "Weekly"
            weekdays = ["Friday"]
            weeks    = ["First", "Last"]
          }
          retention_yearly = {
            count    = 10
            format_type = "Weekly"
            weekdays = ["Monday"]
            weeks    = ["Last"]
            months   = ["January"]
          }
        }
        policy2 = {
          name      = "SQLDataBase-Daily"
          vault_key = "asr1"
          rg_key    = "primary"
          timezone  = "UTC"
          compression_enabled = false
          policy_type = "Full"

          backup = {
            frequency = "Daily"
            frequency_in_minutes = "30"
            time      = "23:00"

          }
          simple_retention = {
            count = 14
          }

          retention_daily = {
            count    = 14
          }

          retention_monthly = {
            count    = 24
            format_type = "Weekly"
            weekdays = ["Friday"]
            weeks    = ["First", "Last"]
          }
          retention_yearly = {
            count    = 2 
            format_type = "Weekly"
            months   = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"] # Req
            weekdays = ["Monday"]
            weeks    = ["Last"]
          }
        }
        policy3 = {
          name      = "SQL-Simple"
          vault_key = "asr1"
          rg_key    = "primary"
          timezone  = "UTC"
          compression_enabled = false
          policy_type = "Full"

          backup = {
            frequency = "Weekly"
            frequency_in_minutes = "30"
            time      = "23:00"
            weekdays  = ["Monday", "Wednesday", "Friday"]
          }
          simple_retention = {
            count = 10
          }
          retention_weekly = {
            count    = 104
            weekdays  = ["Monday", "Wednesday", "Friday"]
          }
        }
      }

      saphana = {
        policy1 = {
          name      = "SAPHanaDatabase-Weekly"
          vault_key = "asr1"
          rg_key    = "primary"
          timezone  = "UTC"
          compression_enabled = false
          policy_type = "Full"

          backup = {
            frequency = "Weekly"
            frequency_in_minutes = "30"
            time      = "23:00"
            weekdays  = ["Monday", "Wednesday", "Friday"]
          }
          simple_retention = {
            count = 10
          }
          retention_weekly = {
            count    = 104
            weekdays  = ["Monday", "Wednesday", "Friday"]
          }
          retention_monthly = {
            count    = 60
            format_type = "Weekly"
            weekdays = ["Friday"]
            weeks    = ["First", "Last"]
          }
          retention_yearly = {
            count    = 10
            format_type = "Weekly"
            weekdays = ["Monday"]
            weeks    = ["Last"]
            months   = ["January"]
          }
        }
        policy2 = {
          name      = "SAPHanaDatabase-Daily"
          vault_key = "asr1"
          rg_key    = "primary"
          timezone  = "UTC"
          compression_enabled = false
          policy_type = "Full"

          backup = {
            frequency = "Daily"
            frequency_in_minutes = "30"
            time      = "23:00"

          }
          simple_retention = {
            count = 14
          }

          retention_daily = {
            count    = 14
          }

          retention_monthly = {
            count    = 24
            format_type = "Weekly"
            weekdays = ["Friday"]
            weeks    = ["First", "Last"]
          }
          retention_yearly = {
            count    = 2
            format_type = "Weekly"
            months   = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"] # Req
            weekdays = ["Monday"]
            weeks    = ["Last"]
          }
        }
        policy3 = {
          name      = "SAPHanaDatabase-Simple"
          vault_key = "asr1"
          rg_key    = "primary"
          timezone  = "UTC"
          compression_enabled = false
          policy_type = "Full"

          backup = {
            frequency = "Weekly"
            frequency_in_minutes = "30"
            time      = "23:00"
            weekdays  = ["Monday", "Wednesday", "Friday"]
          }
          simple_retention = {
            count = 10
          }
          retention_weekly = {
            count    = 104
            weekdays  = ["Monday", "Wednesday", "Friday"]
          }
        }
      }
    }
  }
}