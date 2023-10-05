
#
# Define a set of settings for the various type of Azure resources
#

diagnostics_definition = {
  event_hub_namespace = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["ArchiveLogs", true, false, 0],
        ["OperationalLogs", true, false, 0],
        ["AutoScaleLogs", true, false, 0],
        ["KafkaCoordinatorLogs", true, false, 0],
        ["KafkaUserErrorLogs", true, false, 0],
        ["EventHubVNetConnectionEvent", true, false, 0],
        ["CustomerManagedKeyUserLogs", true, false, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 0],
      ]
    }

  }

}