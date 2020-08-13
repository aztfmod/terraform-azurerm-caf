
variable resource_id {
  description = "(Required) Fully qualified Azure resource identifier for which you enable diagnostics."
}

variable resource_location {
  description = "(Required) location of the resource"
}

variable diagnostics {
  description = "(Required) Contains the diagnostics setting object."
}

variable profiles {}

# diagnostics is a an object describing the configuration of diagnostics logging for a component, as follows: 
# diagnostics = {
#   name  = "all_diags_to_storage"
#   categories = {
#     log = [
#       # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
#                 ["AzureBackupReport", true, true, 100],
#                 ["AzureSiteRecoveryJobs", true, true, 20],
#                 ["AzureSiteRecoveryEvents", true, true, 30],
#                 ["AzureSiteRecoveryReplicatedItems", true, true, 40],
#                 ["AzureSiteRecoveryReplicationStats", true, true, 50],
#                 ["AzureSiteRecoveryRecoveryPoints", true, true, 60],
#                 ["AzureSiteRecoveryReplicationDataUploadRate", true, true, 70],
#                 ["AzureSiteRecoveryProtectedDiskDataChurn", true, true, 80],
#     ]
#     metric = [
#       #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
#       ["AllMetrics", true, true, 60],
#     ]
#   }

#   destinations = {
#     storage = {
#       storage_account_key = "diaglogs-sea"
#     }
#   }
# }