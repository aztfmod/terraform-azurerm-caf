locals {
  arm_filename = "${path.module}/arm_compute_instance.json"

  # this is the format required by ARM templates
  parameters_body = {
    computeInstanceName = {
      value = azurecaf_name.ci.result
    }
    workspaceName = {
      value = var.machine_learning_workspace_name
    }
    location = {
      value = var.location
    }
    tags = {
      value = local.tags
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
