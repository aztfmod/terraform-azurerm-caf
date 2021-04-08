variable "name" {
  description = "(Required) Specifies the name of the Data Factory Linked Service. Changing this forces a new resource to be created. Must be globally unique"
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Data Factory Linked Service. Changing this forces a new resource"
}

variable "data_factory_name" {
  description = "(Required) The Data Factory name in which to associate the Linked Service with. Changing this forces a new resource"
}

variable "description" {
  description = "(Optional) The description for the Data Factory Linked Service"
}

variable "integration_runtime_name" {
  description = "(Optional) The integration runtime reference to associate with the Data Factory Linked Service"
}

variable "annotations" {
  description = "(Optional) List of tags that can be used for describing the Data Factory Linked Service"
}

variable "parameters" {
  description = "(Optional) A map of parameters to associate with the Data Factory Linked Service"
}

variable "additional_properties" {
  description = "(Optional) A map of additional properties to associate with the Data Factory Linked Service"
}

variable "url" {
  description = "(Required) The endpoint for the Azure Data Lake Storage Gen2 service"
}

variable "use_managed_identity" {
  description = "(Optional) Whether to use the Data Factory's managed identity to authenticate against the Azure Data Lake Storage Gen2 account. Incompatible with service_principal_id and service_principal_key"
}

variable "service_principal_id" {
  description = "(Optional) The service principal id in which to authenticate against the Azure Data Lake Storage Gen2 account. Required if use_managed_identity is true"
}

variable "service_principal_key" {
  description = "(Optional) The service principal key in which to authenticate against the Azure Data Lake Storage Gen2 account. Required if use_managed_identity is true"
}

variable "tenant" {
  description = "(Required) The tenant id or name in which to authenticate against the Azure Data Lake Storage Gen2 account"
}