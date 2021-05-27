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
      value = var.wvd_host_pool.name
    }

    hostpoolResourceGroup = {
      value = var.wvd_host_pool.resource_group_name
    }
    hostpoolLocation = {
      value = var.wvd_host_pool.location
    }
    hostpoolProperties = {
      value = {}
    }
    vmTemplate = {
      value = var.settings.vmTemplate
    }
    administratorAccountUsername = {
      value = var.settings.administratorAccountUsername
    }
    hostpoolToken = {
      value = data.azurerm_key_vault_secret.wvd_hostpool_token.value
    }
    administratorAccountPassword = {
      value = data.azurerm_key_vault_secret.wvd_domain_password.value
    }
    vmAdministratorAccountPassword = {
      value = data.azurerm_key_vault_secret.wvd_vm_password.value
    }
    vmAdministratorAccountUsername = {
      value = var.settings.vmAdministratorAccountUsername
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
      value = var.resource_group_name
    }
    vmLocation = {
      value = var.location
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
      value = try(var.vnets[var.client_config.landingzone_key][var.settings.vnet_key].name, var.vnets[var.settings.lz_key][var.settings.vnet_key].name)

    }
    existingSubnetName = {
      value = try(var.vnets[var.client_config.landingzone_key][var.settings.vnet_key].subnets[var.settings.subnet_key].name, var.vnets[var.settings.lz_key][var.settings.vnet_key].subnets[var.settings.subnet_key].name)
    }
    virtualNetworkResourceGroupName = {
      value = var.resource_group_name
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

  }
}