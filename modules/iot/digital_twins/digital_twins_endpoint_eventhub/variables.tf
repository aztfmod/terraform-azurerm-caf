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

variable "eventhub_primary_connection_string" {
  type        = any
  description = "Event Hub primary connection string from authorization rule"
}

variable "eventhub_secondary_connection_string" {
  type        = any
  description = "Event Hub secondary connection string from authorization rule"
}
