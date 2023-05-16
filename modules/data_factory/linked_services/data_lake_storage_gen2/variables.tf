variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

variable "settings" {
  type        = any
  description = "Used for general parameter."
}

variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Data Factory Linked Service. Changing this forces a new resource to be created. Must be globally unique"
}

variable "data_factory_id" {
  type        = string
  description = "(Required) The Data Factory name in which to associate the Linked Service with. Changing this forces a new resource"
}

variable "description" {
  type        = any
  description = "(Optional) The description for the Data Factory Linked Service"
}

variable "integration_runtime_name" {
  type        = any
  description = "(Optional) The integration runtime reference to associate with the Data Factory Linked Service"
}

variable "annotations" {
  type        = any
  description = "(Optional) List of tags that can be used for describing the Data Factory Linked Service"
}

variable "parameters" {
  type        = any
  description = "(Optional) A map of parameters to associate with the Data Factory Linked Service"
}

variable "additional_properties" {
  type        = any
  description = "(Optional) A map of additional properties to associate with the Data Factory Linked Service"
}

variable "url" {
  type        = any
  description = "(Required) The endpoint for the Azure Data Lake Storage Gen2 service"
}

variable "use_managed_identity" {
  type        = any
  description = "(Optional) Whether to use the Data Factory's managed identity to authenticate against the Azure Data Lake Storage Gen2 account. Incompatible with service_principal_id and service_principal_key"
}

variable "service_principal_id" {
  type        = any
  description = "(Optional) The service principal id in which to authenticate against the Azure Data Lake Storage Gen2 account. Required if use_managed_identity is true"
}

variable "service_principal_key" {
  type        = any
  description = "(Optional) The service principal key in which to authenticate against the Azure Data Lake Storage Gen2 account. Required if use_managed_identity is true"
}

variable "tenant" {
  type        = any
  description = "(Required) The tenant id or name in which to authenticate against the Azure Data Lake Storage Gen2 account"
}
