resource "azurecaf_name" "container_app_env" {
  name = var.settings.name
  # no support for container_app_env resource type so adding cae prefix
  resource_type = "general"
  prefixes      = concat(var.global_settings.prefixes, ["cae"])
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azapi_resource" "container_app_env" {
  type = "Microsoft.App/managedEnvironments@2022-10-01"

  parent_id = local.resource_group.id
  location  = try(var.global_settings.regions[var.settings.region], local.resource_group.location)
  tags      = local.tags

  name = azurecaf_name.container_app_env.result

  body = jsonencode({
    properties = {
      # if destination_key is defined, logs should go to that log analytics workspace
      appLogsConfiguration = !can(var.settings.log_analytics.destination_key) ? null : {
        destination = "log-analytics"
        logAnalyticsConfiguration = {
          # use workspace id that diagnostics_destinations points to
          customerId = var.diagnostics.log_analytics[
            var.diagnostics.diagnostics_destinations.log_analytics[
              var.settings.log_analytics.destination_key
            ].log_analytics_key
          ].workspace_id
          # use shared key of workspace (if defined)
          sharedKey = try(
            var.diagnostics.log_analytics[
              var.diagnostics.diagnostics_destinations.log_analytics[
                var.settings.log_analytics.destination_key
              ].log_analytics_key
            ].primary_shared_key,
          null)
        }
      }
      zoneRedundant = var.settings.zone_redundant
      customDomainConfiguration = var.settings.custom_domain_config == null ? null : {
        dnsSuffix = var.settings.custom_domain_config.dns_suffix
      }
      # daprAIConnectionString = "string"
      # daprAIInstrumentationKey = "string"
      # only define vnet configuration if vnet_key is not null
      vnetConfiguration = var.settings.vnet.vnet_key != null ? {
        dockerBridgeCidr       = var.settings.vnet.docker_bridge_cidr
        infrastructureSubnetId = try(var.vnets[coalesce(var.settings.vnet.lz_key, var.client_config.landingzone_key)][var.settings.vnet.vnet_key].subnets[var.settings.vnet.subnet_key].id, null)
        internal               = var.settings.vnet.internal
        # outboundSettings = {
        #   outBoundType = "string"
        #   virtualNetworkApplianceIp = "string"
        # }
        platformReservedCidr  = var.settings.vnet.platform_reserved_cidr
        platformReservedDnsIP = var.settings.vnet.platform_reserved_dns_ip
        # runtimeSubnetId       = "string"
      } : null
      # workloadProfiles = [
      #   {
      #     maximumCount = int
      #     minimumCount = int
      #     workloadProfileType = "string"
      #   }
      # ]
      zoneRedundant = var.settings.zone_redundant
    }
    sku = {
      name = var.settings.sku
    }
  })
  # make sure all response values are made available
  response_export_values = ["*"]
}
