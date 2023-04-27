variable "monthly_retention" {
  description = "The monthly retention policy for an LTR backup in an ISO 8601 format. Value should be in the following format P{1-12}M example: P2M or P12M"

  validation {
    condition = can(regex("^P(1[0-2]|[1-9])M$", var.monthly_retention)
      ,
      var.monthly_retention
    )
    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value in the following format P{1-12}M example: P2M or P12M:", var.monthly_retention)
  }
}
output "monthly_retention" {
  value = var.monthly_retention
}
