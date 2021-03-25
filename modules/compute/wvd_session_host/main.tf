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
      value = var.settings.hostpoolName
    }
    hostpoolToken = {
      value = var.settings.hostpoolToken
    }
    hostpoolResourceGroup = {
      value = var.settings.hostpoolResourceGroup
    }
    hostpoolLocation = {
      value = var.settings.hostpoolLocation
    }
    hostpoolProperties = {
      value = var.settings.hostpoolProperties
    }
    vmTemplate = {
      value = var.settings.vmTemplate
    }
    administratorAccountUsername = {
      value = var.settings.administratorAccountUsername
    }
    administratorAccountPassword = {
      value = var.settings.administratorAccountPassword
    }
    vmAdministratorAccountUsername = {
      value = var.settings.vmAdministratorAccountUsername
    }
    vmAdministratorAccountPassword = {
      value = var.settings.vmAdministratorAccountPassword
    }
    availabilityOption = {
      value = var.settings.availabilityOption
    }
    availabilitySetName = {
      value = var.settings.availabilitySetName
    }
    createAvailabilitySet = {
      value = var.settings.createAvailabilitySet
    }
    availabilitySetUpdateDomainCount = {
      value = var.settings.availabilitySetUpdateDomainCount
    }
    availabilitySetFaultDomainCount = {
      value = var.settings.availabilitySetFaultDomainCount
    }
    availabilityZone = {
      value = var.settings.availabilityZone
    }
    vmResourceGroup = {
      value = var.settings.vmResourceGroup
    }
    vmLocation = {
      value = var.settings.vmLocation
    }
    vmSize = {
      value = var.settings.vmSize
    }
    vmInitialNumber = {
      value = var.settings.vmInitialNumber
    }
    vmNumberOfInstances = {
      value = var.settings.vmNumberOfInstances
    }
    vmNamePrefix = {
      value = var.settings.vmNamePrefix
    }
    vmImageType = {
      value = var.settings.vmImageType
    }
    vmGalleryImageOffer = {
      value = var.settings.vmGalleryImageOffer
    }
    vmGalleryImagePublisher = {
      value = var.settings.vmGalleryImagePublisher
    }
    vmGalleryImageSKU = {
      value = var.settings.vmGalleryImageSKU
    }
    vmImageVhdUri = {
      value = var.settings.vmImageVhdUri
    }
    vmCustomImageSourceId = {
      value = var.settings.vmCustomImageSourceId
    }
    vmDiskType = {
      value = var.settings.vmDiskType
    }
    vmUseManagedDisks = {
      value = var.settings.vmUseManagedDisks
    }
    storageAccountResourceGroupName = {
      value = var.settings.storageAccountResourceGroupName
    }
    existingVnetName = {
      value = var.settings.existingVnetName
    }
    existingSubnetName = {
      value = var.settings.existingSubnetName
    }
    virtualNetworkResourceGroupName = {
      value = var.settings.virtualNetworkResourceGroupName
    }
    createNetworkSecurityGroup = {
      value = var.settings.createNetworkSecurityGroup
    }
    networkSecurityGroupId = {
      value = var.settings.networkSecurityGroupId
    }
    networkSecurityGroupRules = {
      value = var.settings.networkSecurityGroupRules
    }
    availabilitySetTags = {
      value = var.settings.availabilitySetTags
    }
    networkInterfaceTags = {
      value = var.settings.networkInterfaceTags
    }
    networkSecurityGroupTags = {
      value = var.settings.networkSecurityGroupTags
    }
    virtualMachineTags = {
      value = var.settings.virtualMachineTags
    }
    imageTags = {
      value = var.settings.imageTags
    }
    deploymentId = {
      value = var.settings.deploymentId
    }
    apiVersion = {
      value = var.settings.apiVersion
    }
    ouPath = {
      value = var.settings.ouPath
    }
    domain = {
      value = var.settings.domain
    }
    aadJoin = {
      value = var.settings.aadJoin
    }
    intune = {
      value = var.settings.intune
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