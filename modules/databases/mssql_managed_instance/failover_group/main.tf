terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.99"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
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