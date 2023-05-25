variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  description = "(Required) Used to handle passthrough paramenters."
  validation {
    condition = alltrue(
      [
        for k in keys(var.settings) : contains(
          [
            "api_management_name",
            "api_management",
            "api_name",
            "api",
            "description",
            "display_name",
            "method",
            "operation_id",
            "request",
            "resource_group_name",
            "resource_group",
            "responses",
            "template_parameters",
            "url_template"
          ], k
        )
      ]
    )
    error_message = format("The following attributes are not supported. Adjust your configuration file: %s", join(", ",
      setsubtract(
        keys(var.settings),
        [
          "api_management_name",
          "api_management",
          "api_name",
          "api",
          "description",
          "display_name",
          "method",
          "operation_id",
          "request",
          "resource_group_name",
          "resource_group",
          "responses",
          "template_parameters",
          "url_template"
        ]
      )
      )
    )
  }
}
variable "remote_objects" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
  default     = {}
}
variable "api_management_name" {
  description = " The Name of the API Management Service where the API exists. Changing this forces a new resource to be created."
}
variable "api_name" {
  description = " The Name of the API."
}
variable "resource_group_name" {
  description = " The Name of the Resource Group in which the API Management Service exists. Changing this forces a new resource to be created."
}
