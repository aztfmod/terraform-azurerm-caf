variable "license_type" {
  description = "The license type. Possible values are 'LicenseIncluded' (regular price inclusive of a new SQL license) and 'BasePrice' (discounted AHB price for bringing your own SQL licenses)."
  default     = "BasePrice"
  nullable    = false

  validation {
    condition = contains(
      [
        "LicenseIncluded",
        "BasePrice"
      ],
      var.license_type
    )
    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value: %s",
      var.license_type,
      join(", ",
        [
          "LicenseIncluded",
          "BasePrice"
        ]
      )
    )
  }
}
output "license_type" {
  value = var.license_type
}
#