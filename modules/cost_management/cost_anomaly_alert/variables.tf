variable "settings" {
  description = "Configuration object for the cost anomaly alert"
  validation {
    condition = var.settings.message == "" || length(var.settings.message) < 251
    error_message = "Maximum length of the message is 250"
  }
}