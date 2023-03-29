variable "vcores" {
  description = "The number of vCores for Gen5. Allowed values: 8, 16, 24, 32, 40, 64, 80."
  default     = 8
  nullable    = false

  validation {
    condition = contains(
      [
        4,
        8,
        16,
        24,
        32,
        40,
        64,
        80
      ],
      var.vcores
    )
    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value: %s",
      var.vcores,
      join(", ",
        [
          4,
          8,
          16,
          24,
          32,
          40,
          64,
          80
        ]
      )
    )
  }
}
output "vCores" {
  value = var.vcores
}