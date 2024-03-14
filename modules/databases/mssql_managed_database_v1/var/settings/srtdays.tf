variable "short_term_retention_days" {
  description = "short_term_retention_days (Optional) .The backup retention period in days. This is how many days Point-in-Time Restore will be supported. Value must be atleast 1"
  nullable    = true

  validation {
    condition = var.short_term_retention_days == null ? true : var.short_term_retention_days >= 1

    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value of 1 or more days", var.short_term_retention_days)
  }
}
output "short_term_retention_days" {
  value = var.short_term_retention_days
}