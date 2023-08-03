variable "minimal_tls_version" {
  description = "minimal tls version. Allowed values are  '1.0', '1.1', '1.2'"
  default     = "1.2"
  nullable    = false

  validation {
    condition = contains(
      [
        "1.0",
        "1.1",
        "1.2"
      ],
      var.minimal_tls_version
    )
    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value: %s",
      var.minimal_tls_version,
      join(", ",
        [
          "1.0",
          "1.1",
          "1.2"
        ]
      )
    )
  }
}
output "minimal_tls_version" {
  value = var.minimal_tls_version
}
#