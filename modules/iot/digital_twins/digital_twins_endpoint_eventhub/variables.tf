variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "name" {
  description = "(Required) Name of the Digital Twins Endpoint Eventhub"
}

variable "digital_twins_id" {
  description = "(Required) ID of the Digital Twins"
}

variable "eventhub_primary_connection_string" {
  description = "Event Hub primary connection string from authorization rule"
}

variable "eventhub_secondary_connection_string" {
  description = "Event Hub secondary connection string from authorization rule"
}
