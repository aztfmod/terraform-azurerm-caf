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

variable "eventgrid_topic_endpoint" {
  type        = any
  description = "Event Grid Topic  Endpoint"
}

variable "eventgrid_topic_primary_access_key" {
  type        = any
  description = "Event Grid Topic Primary Access Key"
}

variable "eventgrid_topic_secondary_access_key" {
  type        = any
  description = "Event Grid Topic Secondary Access Key"
}
