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
    computeInstanceName = {
      value = var.settings.computeInstanceName
    }
    workspaceName = {
      value = var.machine_learning_workspace_name
    }
    location = {
      value = var.location
    }
    vmSize = {
      value = var.settings.vmSize
    }
    adminUserName = {
      value = var.settings.adminUserName
    }
    sshAccess = {
      value = var.settings.sshAccess
    }
    adminUserSshPublicKey = {
      value = var.settings.adminUserSshPublicKey
    }
    virtualNetworkSubnet = {
      value = var.subnet_id
    }
  }
}
