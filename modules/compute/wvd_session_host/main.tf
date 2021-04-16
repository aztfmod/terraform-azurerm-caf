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
      value = var.host_pool_name
    }
    hostpoolToken = {
      value = var.keyvaults[try(var.settings.hostpoolToken.lz_key, var.client_config.landingzone_key)][var.settings.hostpoolToken.keyvault_key].id
    }
    hostpoolResourceGroup = {
      value = var.resource_group_name
    }
    hostpoolLocation = {
      value = var.location
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
    # hostPoolKeyvaultId = {
    #   value = var.key_vaults[try(var.settings.host_pool.lz_key, local.client_config.landingzone_key)][var.settings.host_pool.keyvault_key].id
    # }
    # vmKeyvaultId = {
    #   value = var.key_vaults[try(var.settings.session_vm.lz_key, local.client_config.landingzone_key)][var.settings.session_vm.keyvault_key].id
    # }
    administratorAccountPassword = {
      value = var.keyvaults[var.settings.administrator.lz_key][var.settings.administrator.keyvault_key].id
    }
    vmAdministratorAccountPassword = {
      value = var.keyvaults[var.settings.vmadministrator.lz_key][var.settings.vmadministrator.keyvault_key].id
    }
    vmAdministratorAccountUsername = {
      value = var.settings.vmAdministratorAccountUsername
    }
    # vmAdministratorAccountPassword = {        
    #   value = var.key_vaults[try(var.settings.session_vm.lz_key, local.client_config.landingzone_key)][var.settings.session_vm.keyvault_key].id
    # }
    # vmAdministratorAccountPassword = data.azurerm_key_vault_secret.wvd-vm-password.value
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
      value = var.settings.existingVnetName
    }
    existingSubnetName = {
      value = var.settings.existingSubnetName
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