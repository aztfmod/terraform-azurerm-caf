variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "tags" {
  description = "(Required) map of tags for the EventGrid Domain"
}

variable "name" {
  description = "(Required) Specifies the name of the EventGrid Domain resource. Changing this forces a new resource to be created."
}

variable "location" {
  description = "(Required) Resource Location"
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which the EventGrid Domain exists. Changing this forces a new resource to be created."
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
  default     = {}
}

variable "identity" {
  default = null
}

variable "input_schema" {
  description = "(Optional) Specifies the schema in which incoming events will be published to this domain. Allowed values are CloudEventSchemaV1_0, CustomEventSchema, or EventGridSchema"
  type        = string
  default     = "EventGridSchema"

  validation {
    condition     = contains(["CloudEventSchemaV1_0", "CustomEventSchema", "EventGridSchema"], var.input_schema)
    error_message = "Allowed values are CloudEventSchemaV1_0, CustomEventSchema, or EventGridSchema."
  }
}

variable "input_mapping_fields" {
  default = null
}

variable "inbound_ip_rule" {
  default = {
  }
}


variable "public_network_access_enabled" {
  description = "(Optional) Whether or not public network access is allowed for this server. "
  type        = bool
  default     = true

  validation {
    condition     = contains([true, false], var.public_network_access_enabled)
    error_message = "Allowed values are true or false."
  }
}

variable "local_auth_enabled" {
  description = "(Optional) Whether local authentication methods is enabled for the EventGrid Domain."
  type        = bool
  default     = true

  validation {
    condition     = contains([true, false], var.local_auth_enabled)
    error_message = "Allowed values are true or false."
  }
}

variable "auto_create_topic_with_first_subscription" {
  description = "(Optional) Whether local authentication methods is enabled for the EventGrid Domain."
  type        = bool
  default     = true

  validation {
    condition     = contains([true, false], var.auto_create_topic_with_first_subscription)
    error_message = "Allowed values are true or false."
  }
}

variable "auto_delete_topic_with_last_subscription" {
  description = "(Optional) Whether local authentication methods is enabled for the EventGrid Domain."
  type        = bool
  default     = true

  validation {
    condition     = contains([true, false], var.auto_delete_topic_with_last_subscription)
    error_message = "Allowed values are true or false."
  }
}

variable "combined_objects" {
  default = {}
}


variable "vnets" {}
variable "private_endpoints" {}
variable "subnet_id" {}
variable "resource_groups" {}
variable "private_dns" {
  default = {}
}
variable "remote_objects" {
  default = null
}


