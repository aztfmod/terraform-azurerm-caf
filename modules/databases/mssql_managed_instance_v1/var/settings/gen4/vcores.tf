variable "vcores" {
  description = "The number of vCores for Gen4. Allowed values: 8, 16, 24"
  default     = 8
  nullable    = false

  validation {
    condition = contains(
      [

        8,
        16,
        24
      ],
      var.vcores
    )
    error_message = format("Gen4 sku does not support this value: '%s'. \nAdjust the value for vcores with: %s",
      var.vcores,
      join(", ",
        [
          8,
          16,
          24
        ]
      )
    )
  }
}
output "vcores" {
  value = var.vcores
}