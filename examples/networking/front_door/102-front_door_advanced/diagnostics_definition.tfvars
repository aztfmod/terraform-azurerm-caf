
#
# Define a set of settings for the various type of Azure resources
#

diagnostics_definition = {

  azure_front_door = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["FrontdoorAccessLog", true, false, 0],
        ["FrontdoorWebApplicationFirewallLog", true, false, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 0],
      ]
    }
  }

}