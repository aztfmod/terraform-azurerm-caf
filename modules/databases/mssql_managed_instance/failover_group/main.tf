terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  arm_filename = "${path.module}/arm_mi_failover_group.json"

  # this is the format required by ARM templates
  parameters_body = {
    name = {
      value = azurecaf_name.mifailover.result
    }
    primaryManagedInstanceId = {
      value = var.primaryManagedInstanceId
    }
    partnerManagedInstanceId = {
      value = var.partnerManagedInstanceId
    }
    partnerRegion = {
      value = var.partnerRegion
    }
    readWriteFailoverPolicy = {
      value = var.settings.readWriteEndpoint.failoverPolicy
    }
    readWriteGraceMinutes = {
      value = try(var.settings.readWriteEndpoint.failoverWithDataLossGracePeriodMinutes, 60)
    }
    readOnlyFailoverPolicy = {
      value = try(var.settings.readOnlyEndpoint.failoverPolicy, "Disabled")
    }
  }
}