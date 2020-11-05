<<<<<<< HEAD
<<<<<<< HEAD:modules/analytics/machine_learning/compute_instance/main.tf
=======
locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(local.module_tag, var.tags, try(var.settings.tags, null))
}

>>>>>>> 26c5af3f4a89bec1bca1fa9b304dd5dd5fe20aef:modules/analytics/synapse/spark_pool/main.tf
=======
>>>>>>> 26c5af3f4a89bec1bca1fa9b304dd5dd5fe20aef
terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

<<<<<<< HEAD
<<<<<<< HEAD:modules/analytics/machine_learning/compute_instance/main.tf
=======
>>>>>>> 26c5af3f4a89bec1bca1fa9b304dd5dd5fe20aef
locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
<<<<<<< HEAD
  tags = merge(var.tags, local.module_tag)

}
=======
>>>>>>> 26c5af3f4a89bec1bca1fa9b304dd5dd5fe20aef:modules/analytics/synapse/spark_pool/main.tf
=======
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
>>>>>>> 26c5af3f4a89bec1bca1fa9b304dd5dd5fe20aef
