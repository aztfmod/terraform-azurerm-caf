
#
# Define the settings for the diagnostics settings
# Demonstrate how to log diagnostics in the correct region
# Different profiles to target different operational teams
#
diagnostics_definition = {
  azurerm_virtual_desktop_workspace = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["Checkpoint", true, true, 7],
        ["Error", true, true, 7],
        ["Management", true, true, 7],
        ["Feed", true, true, 7],
      ]
    }
  }

  azurerm_virtual_desktop_host_pool = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["Checkpoint", true, true, 7],
        ["Error", true, true, 7],
        ["Management", true, true, 7],
        ["Connection", true, true, 7],
        ["HostRegistration", true, true, 7],
        ["AgentHealthStatus", true, true, 7],
      ]
    }
  }

  azurerm_virtual_desktop_application_group = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["Checkpoint", true, true, 7],
        ["Error", true, true, 7],
        ["Management", true, true, 7],
      ]
    }
  }

}
