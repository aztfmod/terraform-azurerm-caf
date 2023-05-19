resource "azapi_resource" "sqlmi_failover_group" {
  type      = "Microsoft.Sql/locations/instanceFailoverGroups@2022-05-01-preview"
  name      = var.settings.name
  parent_id = var.managed_instance.resource_group_id
  body = jsonencode({
    properties = {
      managedInstancePairs = [
        {
          primaryManagedInstanceId = var.managed_instance.id
          partnerManagedInstanceId = var.partner_managed_instance_id
        }
      ]
      partnerRegions = [
        {
          location = var.managed_instance.location
        }
      ]
      readWriteEndpoint = {
        failoverPolicy                         = try(var.settings.read_write_endpoint_failover_policy.mode, "Manual")
        failoverWithDataLossGracePeriodMinutes = var.settings.read_write_endpoint_failover_policy.mode == "Automatic" ? var.settings.read_write_endpoint_failover_policy.grace_minutes : null
      }
      secondaryType = try(var.settings.secondary_type, "Standby")
    }
  })
}
