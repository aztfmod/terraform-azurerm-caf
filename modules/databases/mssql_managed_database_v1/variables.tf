variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "server_id" {}

variable "settings" {
  validation {
    condition = alltrue(
      [
        for k in keys(var.settings) : contains(
          [
            "long_term_retention_policy",
            "lz_key",
            "name",
            "short_term_retention_days",
            "version",
            "mi_server_key"
          ], k
        )
      ]
    )
    error_message = format("The following attributes are not supported. Adjust your configuration file: %s", join(", ",
      setsubtract(
        keys(var.settings),
        [
          "long_term_retention_policy",
          "lz_key",
          "name",
          "short_term_retention_days",
          "version",
          "mi_server_key"
        ]
      )
      )
    )
  }
}
