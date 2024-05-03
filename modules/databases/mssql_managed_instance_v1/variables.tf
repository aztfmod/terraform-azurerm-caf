variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {}
variable "inherit_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "subnet_id" {}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "resource_group" {
  description = "(Required) The resource group where to create the resource."
  default     = {}
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "managed_identities" {
}

variable "group_id" {
  description = "The ID of the Azure Active Directory Group that should be granted access to the Managed Instance Administrators."
  type        = string
  default     = null
}

variable "keyvault" {}
variable "resource_groups" {}
variable "vnets" {}
variable "private_endpoints" {}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "private_dns" {
  default = {}
}
variable "primary_server_id" {}

variable "settings" {
  validation {
    condition = alltrue(
      [
        for k in keys(var.settings) : contains(
          [
            "administrator_login_password",
            "administrator_login",
            "administrators",
            "authentication_mode",
            "backup_storage_redundancy",
            "collation",
            "identity",
            "instance_pool_id",
            "keyvault",
            "license_type",
            "maintenance_configuration_name",
            "mi_create_mode",
            "minimal_tls_version",
            "name",
            "networking",
            "private_endpoints",
            "primary_server",
            "proxy_override",
            "public_data_endpoint_enabled",
            "region",
            "resource_group",
            "restore_point_in_time",
            "service_principal",
            "sku",
            "storage_size_in_gb",
            "tags",
            "timezone_id",
            "transparent_data_encryption",
            "vcores",
            "version",
            "zone_redundant"
          ], k
        )
      ]
    )
    error_message = format("The following attributes are not supported. Adjust your configuration file: %s", join(", ",
      setsubtract(
        keys(var.settings),
        [
          "administrator_login_password",
          "administrator_login",
          "administrators",
          "authentication_mode",
          "backup_storage_redundancy",
          "collation",
          "identity",
          "instance_pool_id",
          "keyvault",
          "license_type",
          "maintenance_configuration_name",
          "mi_create_mode",
          "minimal_tls_version",
          "name",
          "networking",
          "primary_server",
          "proxy_override",
          "public_data_endpoint_enabled",
          "region",
          "resource_group",
          "restore_point_in_time",
          "service_principal",
          "sku",
          "storage_size_in_gb",
          "tags",
          "timezone_id",
          "transparent_data_encryption",
          "vcores",
          "version",
          "zone_redundant"

        ]
      )
      )
    )
  }
}

