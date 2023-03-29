variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "server_id" {}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "sourceDatabaseId" {
  default = ""
}

variable "settings" {
  validation {
    condition = alltrue(
      [
        for k in keys(var.settings) : contains(
          [
            "long_term_retention_policy",
            "managed_instance_id",
            "name",
            "short_term_retention_policy"
          ], k
        )
      ]
    )
    error_message = format("The following attributes are not supported. Adjust your configuration file: %s", join(", ",
      setsubtract(
        keys(var.settings),
        [
          "long_term_retention_policy",
          "managed_instance_id",
          "name",
          "short_term_retention_policy"
        ]
      )
      )
    )
  }
}
