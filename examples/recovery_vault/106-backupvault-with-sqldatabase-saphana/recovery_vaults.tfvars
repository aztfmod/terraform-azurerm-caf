recovery_vaults = {
  asr1 = {
    name               = "vault_re1"
    resource_group_key = "primary"
    region             = "region1"
    vnet_key           = "vnet_region1"
    subnet_key         = "asr_subnet"

    soft_delete_enabled = false
    backup_policies = {
      vm_workloads = {
        sql1 = {
          name      = "SQLDataBase-Weekly"
          workload_type = "SQLDataBase"
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
        sql2 = {
          name      = "SQLDataBase-Daily"
          workload_type = "SQLDataBase"
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
        saphana1 = {
          name      = "SAPHanaDatabase-Weekly"
          workload_type = "SAPHanaDatabase"
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
        saphana2 = {
          name      = "SAPHanaDatabase-Daily"
          workload_type = "SAPHanaDatabase"
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
      }
    }
  }
}