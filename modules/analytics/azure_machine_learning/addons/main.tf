terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  # tags         = merge(var.tags, local.module_tag)
  arm_filename = "${path.module}/arm_compute_instance.json"

  # this is the format required by ARM templates
  parameters_body = {
    workspaceName = {
      value = azurecaf_name.ase.result
    }
    computeInstanceName = {
      value = var.resource_group_name
    }
    location = {
      value = var.location
    }
    vmSize = {
      value = var.kind
    }
    sshAccess = {
      value = var.zone
    }
    adminUserSshPublicKey = {
      value = var.internalLoadBalancingMode
    }
    virtualNetworkSubnet = {
      value = var.subnet_id
    }
  }
}
