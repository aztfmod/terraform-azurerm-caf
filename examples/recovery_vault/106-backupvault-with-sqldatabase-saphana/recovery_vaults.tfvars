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
        sql = {
          name                = "SQLTest"
          workload_type       = "SQLDataBase"
          vault_key           = "asr1"
          rg_key              = "primary"
          timezone            = "UTC"
          compression_enabled = false
          protection_policies = {
            sqlfull = {
              policy_type = "Full"
              backup = {
                frequency = "Daily"
                time      = "15:00"
              }
              retention_daily = {
                count = 8
              }
            }
            sqllog = {
              policy_type = "Log"
              backup = {
                frequency_in_minutes = 15
              }
              simple_retention = {
                count = 8
              }
            }
          }
        }
        saphana = {
          name                = "SAPHANATest"
          workload_type       = "SAPHanaDatabase"
          vault_key           = "asr1"
          rg_key              = "primary"
          timezone            = "UTC"
          compression_enabled = false
          protection_policies = {
            saphanafull = {
              policy_type = "Full"
              backup = {
                frequency = "Daily"
                time      = "15:00"
              }
              retention_daily = {
                count = 8
              }
            }
            saphanalog = {
              policy_type = "Log"
              backup = {
                frequency_in_minutes = 15
              }
              simple_retention = {
                count = 8
              }
            }
          }
        }
      }
    }
  }
}