diagnostics_definition = {
  networking_all = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["VMProtectionAlerts", true, true, 90],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, true, 90],
      ]
    }
  }

  public_ip_address = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["DDoSProtectionNotifications", true, true, 90],
        ["DDoSMitigationFlowLogs", true, true, 90],
        ["DDoSMitigationReports", true, true, 90],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, true, 90],
      ]
    }
  }
  azure_firewall = {
    name = "operational_logs_and_metrics"

    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AzureFirewallApplicationRule", true, true, 90],
        ["AzureFirewallNetworkRule", true, true, 90],
        ["AzureFirewallDnsProxy", true, true, 90],
        ["AZFWApplicationRule", true, true, 90],
        ["AZFWApplicationRuleAggregation", true, true, 90],
        ["AZFWDnsQuery", true, true, 90],
        ["AZFWFatFlow", true, true, 90],
        ["AZFWFlowTrace", true, true, 90],
        ["AZFWFqdnResolveFailure", true, true, 90],
        ["AZFWIdpsSignature", true, true, 90],
        ["AZFWNatRule", true, true, 90],
        ["AZFWNatRuleAggregation", true, true, 90],
        ["AZFWNetworkRule", true, true, 90],
        ["AZFWNetworkRuleAggregation", true, true, 90],
        ["AZFWThreatIntel", true, true, 90],
      ]
      metric = [
        # ["Category name",  "Metric Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, true, 90],
      ]
    }
  }
}
