recovery_vaults = {
  asr1 = {
    name               = "vault_re1"
    resource_group_key = "primary"
    region             = "region1"
    vnet_key           = "vnet_region1"
    subnet_key         = "asr_subnet"

    soft_delete_enabled = false



    backup_policies = {
      vms = {
        policy1 = {
          name      = "VMBackupPolicy1"
          vault_key = "asr1"
          rg_key    = "primary"
          timezone  = "UTC"
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
            count    = 77
            weekdays = ["Sunday"]
            weeks    = ["Last"]
            months   = ["January"]
          }
        }
      }
    }

  }
}