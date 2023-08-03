variable "vcores" {
  description = "The number of vCores for Gen5. Allowed values: 8, 16, 24, 32, 40, 64, 80."
  default     = 4
  nullable    = false
  type        = number

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
    error_message = format("Gen5 sku does not support this value: '%s'. \nAdjust the value for vcores with: %s",
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
output "vcores" {
  value = var.vcores
}