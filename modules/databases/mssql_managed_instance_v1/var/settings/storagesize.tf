variable "storage_size_in_gb" {
  description = "storage_size_in_gb . Value must be in multiples of 32 with allowed value max value 16384"
  default     = 32
  nullable    = false

  validation {
    condition = var.storage_size_in_gb % 32 == 0 && var.storage_size_in_gb >= 32 && var.storage_size_in_gb <= 16384

    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value in multiples of 32 with max allowed value 16384", var.storage_size_in_gb)
  }
}
output "storage_size_in_gb" {
  value = var.storage_size_in_gb
}
#