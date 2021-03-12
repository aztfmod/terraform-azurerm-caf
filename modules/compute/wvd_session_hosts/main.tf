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
  tags         = merge(local.module_tag, try(var.settings.tags, null), var.base_tags)
  arm_filename = "${path.module}/arm_sessionhosts.json"

  # this is the format required by ARM templates
  parameters_body = {
    hostpoolName = {
      value = var.location
    }
    hostpoolToken = {
      value = var.location
    }
    hostpoolResourceGroup = {
      value = var.location
    }
    hostpoolLocation = {
      value = var.location
    }
    hostpoolProperties = {
      value = var.location
    }
    vmTemplate = {
      value = var.location
    }
    administratorAccountUsername = {
      value = var.location
    }
    administratorAccountPassword = {
      value = var.location
    }
    vmAdministratorAccountUsername = {
      value = var.location
    }
    vmAdministratorAccountPassword = {
      value = var.location
    }
    createAvailabilitySet = {
      value = var.location
    }
    vmResourceGroup = {
      value = var.location
    }
    vmLocation = {
      value = var.location
    }
    vmSize = {
      value = var.location
    }
    vmInitialNumber = {
      value = var.location
    }
    vmNumberOfInstances = {
      value = var.location
    }
    vmNamePrefix = {
      value = var.location
    }
    vmImageType = {
      value = var.location
    }
    vmGalleryImageOffer = {
      value = var.location
    }
    vmGalleryImagePublisher = {
      value = var.location
    }
    vmGalleryImageSKU = {
      value = var.location
    }
    vmImageVhdUri = {
      value = var.location
    }
    vmCustomImageSourceId = {
      value = var.location
    }
    vmDiskType = {
      value = var.location
    }
    vmUseManagedDisks = {
      value = var.location
    }
    storageAccountResourceGroupName = {
      value = var.location
    }
    existingVnetName = {
      value = var.location
    }
    existingSubnetName = {
      value = var.location
    }
    virtualNetworkResourceGroupName = {
      value = var.location
    }
    createNetworkSecurityGroup = {
      value = var.location
    }
    networkSecurityGroupId = {
      value = var.location
    }
    networkSecurityGroupRules = {
      value = var.location
    }
    availabilitySetTags = {
      value = var.location
    }
    networkInterfaceTags = {
      value = var.location
    }
    networkSecurityGroupTags = {
      value = var.location
    }
    virtualMachineTags = {
      value = var.location
    }
    imageTags = {
      value = var.location
    }
    deploymentId = {
      value = var.location
    }
    apiVersion = {
      value = var.location
    }
    ouPath = {
      value = var.location
    }
    domain = {
      value = var.location
    }

    # serverName = {
    #   value = var.server_name
    # }
    # dbName = {
    #   value = azurecaf_name.manageddb.result
    # }
    # location = {
    #   value = var.location
    # }
    # collation = {
    #   value = try(var.settings.collation, "SQL_Latin1_General_CP1_CI_AS")
    # }
    # createMode = {
    #   value = try(var.settings.createMode, "Default")
    # }
    # sourceDatabaseId = {
    #   value = var.sourceDatabaseId
    # }
    # restorePointInTime = {
    #   value = try(var.settings.createMode, null) == "PointInTimeRestore" ? var.settings.restorePointInTime : ""
    # }
    # longTermRetentionBackupResourceId = {
    #   value = try(var.settings.longTermRetentionBackupResourceId, "")
    # }
    # retentionDays = {
    #   value = try(var.settings.retentionDays, 7)
    # }
    # tags = {
    #   value = local.tags
    }
  }
}