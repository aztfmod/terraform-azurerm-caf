variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "tags" {
  description = "Tags to be used for this resource deployment."
  type        = map(any)
  default     = {}
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
  default     = {}
}
variable "name" {
  description = "(Required) The name of the PowerBI Embedded. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "sku_name" {
  description = "(Required) Sets the PowerBI Embedded's pricing level's SKU. Possible values include: A1, A2, A3, A4, A5, A6."
  type        = string

  validation {
    condition     = contains(["A1", "A2", "A3", "A4", "A5", "A6"], var.sku_name)
    error_message = "Allowed values are A1, A2, A3, A4, A5 or A6."
  }
}

variable "administrators" {
  description = "(Required) A set of administrator user identities, which manages the Power BI Embedded and must be a member user or a service principal in your AAD tenant."
  type        = list(string)
}

variable "mode" {
  description = "(Optional) Sets the PowerBI Embedded's mode. Possible values include: Gen1, Gen2. Defaults to Gen1. Changing this forces a new resource to be created."
  default     = "Gen1"
  type        = string

  validation {
    condition     = contains(["Gen1", "Gen2"], var.mode)
    error_message = "Provide a valid value for retention period in days."
  }
}

variable "resource_group_name" {
  description = "Resource group object"
}

variable "settings" {}




