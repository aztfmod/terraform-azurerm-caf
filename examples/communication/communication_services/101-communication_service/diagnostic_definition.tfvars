diagnostics_definition = {
  communication_services = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AuthOperational", true, true, 30],
        ["ChatOperational", true, true, 30],
        ["SMSOperational", true, true, 30],
        ["Usage", true, true, 30],
        ["CallSummary", true, true, 30],
        ["CallDiagnostics", true, true, 30],       
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["Traffic", true, true, 30],
      ]
    }
  }
}