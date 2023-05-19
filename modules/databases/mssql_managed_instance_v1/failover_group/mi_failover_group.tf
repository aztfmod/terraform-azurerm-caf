resource "azapi_resource" "sqlmi_failover_group" {
  type      = "Microsoft.Sql/locations/instanceFailoverGroups@2022-05-01-preview"
  name      = var.settings.name
  parent_id = format("%s/providers/Microsoft.Sql/locations/%s", var.managed_instance.resource_group_id, var.managed_instance.location)
  body = jsonencode({
    properties = {
      managedInstancePairs = [
        {
          primaryManagedInstanceId = var.managed_instance.id
          partnerManagedInstanceId = var.partner_managed_instance.id
        }
      ]
      partnerRegions = [
        {
          location = var.partner_managed_instance.location
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
