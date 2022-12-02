variable "client_config" {
  type        = any
  description = "Client configuration object"
}

variable "global_settings" {
  type        = any
  description = "Global settings object"
}

variable "local_combined_resources" {
  type        = any
  description = "object of local combined resources"
}

variable "settings" {
  type        = any
  description = "Configuration object for the consumption budget subscription"
}