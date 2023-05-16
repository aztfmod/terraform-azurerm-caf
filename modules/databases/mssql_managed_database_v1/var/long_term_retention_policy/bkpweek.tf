variable "week_of_year" {
  description = "The week of year to take the yearly backup. Value has to be between 1 and 52."
  nullable    = true

  validation {
    condition = var.week_of_year >= 1 && var.week_of_year <= 52

    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value in multiples of 32 with max allowed value 16384", var.week_of_year)
  }
}
output "week_of_year" {
  value = var.week_of_year
}