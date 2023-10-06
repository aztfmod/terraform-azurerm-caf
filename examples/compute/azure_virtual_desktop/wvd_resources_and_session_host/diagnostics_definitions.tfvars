
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
        ["Checkpoint", true, true, 0],
        ["Error", true, true, 0],
        ["Management", true, true, 0],
        ["Feed", true, true, 0],
      ]
    }
  }

  azurerm_virtual_desktop_host_pool = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["Checkpoint", true, true, 0],
        ["Error", true, true, 0],
        ["Management", true, true, 0],
        ["Connection", true, true, 0],
        ["HostRegistration", true, true, 0],
        ["AgentHealthStatus", true, true, 0],
      ]
    }
  }

  azurerm_virtual_desktop_application_group = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["Checkpoint", true, true, 0],
        ["Error", true, true, 0],
        ["Management", true, true, 0],
      ]
    }
  }

}
