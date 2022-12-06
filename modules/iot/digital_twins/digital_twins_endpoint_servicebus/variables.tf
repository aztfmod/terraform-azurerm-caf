variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}

variable "name" {
  type        = string
  description = "(Required) Name of the Digital Twins Endpoint Eventhub"
}

variable "digital_twins_id" {
  type        = any
  description = "(Required) ID of the Digital Twins"
}

variable "servicebus_primary_connection_string" {
  type        = any
  description = "Servicebus Primary Connection String"
}

variable "servicebus_secondary_connection_string" {
  type        = any
  description = "Servicebus Secondary Connection String"
}
