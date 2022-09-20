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

variable "eventgrid_topic_endpoint" {
  description = "Event Grid Topic  Endpoint"
}

variable "eventgrid_topic_primary_access_key" {
  description = "Event Grid Topic Primary Access Key"
}

variable "eventgrid_topic_secondary_access_key" {
  description = "Event Grid Topic Secondary Access Key"
}
