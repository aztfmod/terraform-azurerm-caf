variable "global_settings" {
  description = "Global settings object (see module README.md)"
  default     = null
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
  default     = null
}

variable "base_tags" {
  description = "(Optional)Base tags for the resource to be inherited from the resource group."
  type        = map(any)
  default     = {}
}

variable "combined_objects" {
  default = {}
}

variable "name" {
  description = "(Required) Specifies the name of the EventGrid Topic resource. Changing this forces a new resource to be created."
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which the EventGrid Topic exists. Changing this forces a new resource to be created."
}


variable "identity" {
  description = <<EOT
  A identity block supports the following:
  type - Specifies the type of Managed Service Identity that is configured on this Event Grid Topic.
  principal_id - Specifies the Principal ID of the System Assigned Managed Service Identity that is configured on this Event Grid Topic.
  tenant_id - Specifies the Tenant ID of the System Assigned Managed Service Identity that is configured on this Event Grid Topic.
  identity_ids - A list of IDs for User Assigned Managed Identity resources to be assigned.
  EOT
  default     = null
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
  description = <<EOT
  input_mapping_fields supports the following:
  id - (Optional) Specifies the id of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.
  topic - (Optional) Specifies the topic of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.
  event_type - (Optional) Specifies the event type of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.
  event_time - (Optional) Specifies the event time of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.
  data_version - (Optional) Specifies the data version of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.
  subject - (Optional) Specifies the subject of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.
  EOT
  default     = null
}

variable "input_mapping_default_values" {
  description = <<EOT
  input_mapping_default_values supports the following:
  event_type - (Optional) Specifies the default event type of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.
  data_version - (Optional) Specifies the default data version of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.
  subject - (Optional) Specifies the default subject of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.
  EOT
  default     = null
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

variable "inbound_ip_rule" {
  description = <<EOT
  A inbound_ip_rule block supports the following:
  ip_mask - (Required) The ip mask (CIDR) to match on.
  action - (Optional) The action to take when the rule is matched. Possible values are Allow.
  EOT
  default     = null
}

variable "tags" {
  description = "(Optional) map of tags for the EventGrid Topic"
  type        = map(any)
  default     = {}
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


