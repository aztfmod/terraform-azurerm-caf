variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "subnet_id" {}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "primary_server_id" {
  default = ""
}
variable "keyvault" {}


variable "resource_group_id" {}

variable "settings" {
  validation {
    condition = alltrue(
      [
        for k in keys(var.settings) : contains(
          [
            "administrator_login_password",
            "administrator_login",
            "authentication_mode",
            "administrators",
            "collation",
            "primary_server_id",
            "instance_pool_id",
            "keyvault",
            "license_type",
            "minimal_tls_version",
            "mi_create_mode",
            "name",
            "networking",
            "proxy_override",
            "public_data_endpoint_enabled",
            "resource_group",
            "service_principal",
            "sku",
            "backup_storage_redundancy",
            "storage_size_in_gb",
            "timezone_id",
            "vcores",
            "version",
            "zone_redundant",
            "restore_point_in_time"
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
          "authentication_mode",
          "administrators",
          "collation",
          "primary_server_id",
          "instance_pool_id",
          "keyvault",
          "license_type",
          "minimal_tls_version",
          "mi_create_mode",
          "name",
          "networking",
          "proxy_override",
          "public_data_endpoint_enabled",
          "resource_group",
          "service_principal",
          "sku",
          "backup_storage_redundancy",
          "storage_size_in_gb",
          "timezone_id",
          "vcores",
          "version",
          "zone_redundant",
          "restore_point_in_time"
        ]
      )
      )
    )
  }
}

