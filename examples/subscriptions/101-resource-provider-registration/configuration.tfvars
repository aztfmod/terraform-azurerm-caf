resource_provider_registration = {
  container_service = {
    name         = "Microsoft.ContainerService"
    feature_name = "AKS-DataPlaneAutoApprove"
    registered   = true
  }
  network_rule_name_logging = {
    name         = "Microsoft.Network"
    feature_name = "AFWEnableNetworkRuleNameLogging"
    registered   = true
  }
}
