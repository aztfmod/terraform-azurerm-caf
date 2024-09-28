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
diagnostics_definition = {
  azure_site_recovery = {
    name                           = "operational_logs_and_metrics"
    log_analytics_destination_type = "Dedicated"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AzureBackupReport", true, true, 0],
        ["CoreAzureBackup", true, true, 0],
        ["AddonAzureBackupAlerts", true, true, 0],
        ["AddonAzureBackupJobs", true, true, 0],
        ["AddonAzureBackupPolicy", true, true, 0],
        ["AddonAzureBackupProtectedInstance", true, true, 0],
        ["AddonAzureBackupStorage", true, true, 0],
        ["AzureSiteRecoveryJobs", true, true, 0],
        ["AzureSiteRecoveryEvents", true, true, 0],
        ["AzureSiteRecoveryReplicatedItems", true, true, 0],
        ["AzureSiteRecoveryReplicationStats", true, true, 0],
        ["AzureSiteRecoveryRecoveryPoints", true, true, 0],
        ["AzureSiteRecoveryReplicationDataUploadRate", true, true, 0],
        ["AzureSiteRecoveryProtectedDiskDataChurn", true, true, 0],
      ]
      metric = [
        ["AllMetrics", true, true, 0],
      ]
    }
  }
}

diagnostic_event_hub_namespaces = {
  event_hub_namespace1 = {
    name               = "operation_logs"
    resource_group_key = "primary"
    sku                = "Standard"
    region             = "region1"
  }
}

diagnostics_destinations = {
  event_hub_namespaces = {
    central_logs_example = {
      event_hub_namespace_key = "event_hub_namespace1"
    }
  }
}

recovery_vaults = {
  asr1 = {
    name               = "vault_re1"
    resource_group_key = "primary"

    diagnostic_profiles = {
      azure_site_recovery = {
        definition_key   = "azure_site_recovery"
        destination_type = "event_hub"
        destination_key  = "central_logs_example"
      }
    }
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
  }

}
