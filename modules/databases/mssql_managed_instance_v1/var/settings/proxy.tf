variable "proxy_override" {
  description = "minimal tls version. Allowed values are  'Proxy' or 'Redirect"
  default     = "Redirect"
  nullable    = false

  validation {
    condition = contains(
      [
        "Default",
        "Proxy",
        "Redirect"
      ],
      var.proxy_override
    )
    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value: %s",
      var.proxy_override,
      join(", ",
        [
          "Default",
          "Proxy",
          "Redirect"
        ]
      )
    )
  }
}
output "proxy_override" {
  value = var.proxy_override
}
#