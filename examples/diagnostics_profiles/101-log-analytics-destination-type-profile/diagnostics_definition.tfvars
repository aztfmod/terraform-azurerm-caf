diagnostics_definition = {
  networking_all = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["VMProtectionAlerts", true, true, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, true, 0],
      ]
    }
  }

  public_ip_address = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["DDoSProtectionNotifications", true, true, 0],
        ["DDoSMitigationFlowLogs", true, true, 0],
        ["DDoSMitigationReports", true, true, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, true, 0],
      ]
    }
  }
  azure_firewall = {
    name = "operational_logs_and_metrics"

    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AzureFirewallApplicationRule", true, true, 0],
        ["AzureFirewallNetworkRule", true, true, 0],
        ["AzureFirewallDnsProxy", true, true, 0],
        ["AZFWApplicationRule", true, true, 0],
        ["AZFWApplicationRuleAggregation", true, true, 0],
        ["AZFWDnsQuery", true, true, 0],
        ["AZFWFatFlow", true, true, 0],
        ["AZFWFlowTrace", true, true, 0],
        ["AZFWFqdnResolveFailure", true, true, 0],
        ["AZFWIdpsSignature", true, true, 0],
        ["AZFWNatRule", true, true, 0],
        ["AZFWNatRuleAggregation", true, true, 0],
        ["AZFWNetworkRule", true, true, 0],
        ["AZFWNetworkRuleAggregation", true, true, 0],
        ["AZFWThreatIntel", true, true, 0],
      ]
      metric = [
        # ["Category name",  "Metric Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, true, 0],
      ]
    }
  }
}
