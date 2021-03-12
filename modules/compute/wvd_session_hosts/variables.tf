variable global_settings {
  description = "Global settings object (see module README.md)"
}
variable server_name {}
variable settings {}
variable base_tags {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map
}
variable resource_group_name {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable location {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable sourceDatabaseId {
  default = ""
}

variable hostpoolName = {
  value = var.location
}
variable hostpoolToken = {
  value = var.location
}
variable hostpoolResourceGroup = {
  value = var.location
}
variable hostpoolLocation = {
  value = var.location
}
variable hostpoolProperties = {
  value = var.location
}
variable vmTemplate = {
  value = var.location
}
variable administratorAccountUsername = {
  value = var.location
}
variable administratorAccountPassword = {
  value = var.location
}
variable vmAdministratorAccountUsername = {
  value = var.location
}
variable vmAdministratorAccountPassword = {
  value = var.location
}
variable createAvailabilitySet = {
  value = var.location
}
variable vmResourceGroup = {
  value = var.location
}
variable vmLocation = {
  value = var.location
}
variable vmSize = {
  value = var.location
}
variable vmInitialNumber = {
  value = var.location
}
variable vmNumberOfInstances = {
  value = var.location
}
variable vmNamePrefix = {
  value = var.location
}
variable vmImageType = {
  value = var.location
}
variable vmGalleryImageOffer = {
  value = var.location
}
variable vmGalleryImagePublisher = {
  value = var.location
}
variable vmGalleryImageSKU = {
  value = var.location
}
variable vmImageVhdUri = {
  value = var.location
}
variable vmCustomImageSourceId = {
  value = var.location
}
variable vmDiskType = {
  value = var.location
}
variable vmUseManagedDisks = {
  value = var.location
}
variable storageAccountResourceGroupName = {
  value = var.location
}
variable existingVnetName = {
  value = var.location
}
variable existingSubnetName = {
  value = var.location
}
variable virtualNetworkResourceGroupName = {
  value = var.location
}
variable createNetworkSecurityGroup = {
  value = var.location
}
variable networkSecurityGroupId = {
  value = var.location
}
variable networkSecurityGroupRules = {
  value = var.location
}
variable availabilitySetTags = {
  value = var.location
}
variable networkInterfaceTags = {
  value = var.location
}
variable networkSecurityGroupTags = {
  value = var.location
}
variable virtualMachineTags = {
  value = var.location
}
variable imageTags = {
  value = var.location
}
variable deploymentId = {
  value = var.location
}
variable apiVersion = {
  value = var.location
}
variable ouPath = {
  value = var.location
}
variable domain = {
  value = var.location
}
