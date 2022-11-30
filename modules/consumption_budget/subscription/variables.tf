variable "client_config" {
  type        = map(any)
  description = "Client configuration object"
}

variable "global_settings" {
  type        = any
  description = "Global settings object"
}

variable "local_combined_resources" {
  description = "object of local combined resources"
}

variable "settings" {
  type        = any
  description = "Configuration object for the consumption budget subscription"
}