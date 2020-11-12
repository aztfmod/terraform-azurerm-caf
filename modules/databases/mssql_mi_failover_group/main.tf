terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(local.module_tag, try(var.settings.tags, null), var.base_tags)
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
      value = var.settings.readWriteEndpoint.failoverPolicy == "Automatic " ? var.settings.readWriteEndpoint.failoverWithDataLossGracePeriodMinutes : "" 
    }
    readWriteFailoverPolicy = {
      value = try(var.settings.readOnlyEndpoint.failoverPolicy, "Disabled")
    }
  }
}