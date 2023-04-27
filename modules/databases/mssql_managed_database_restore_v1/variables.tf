variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "server_id" {}
variable "server_location" {}
variable "base_tags" {
  type = bool
}
variable "server_tags" {
  default  = {}
  nullable = false
}
variable "source_database_id" {
  type    = string
  default = null
}
variable "settings" {
  validation {
    condition = alltrue(
      [
        for k in keys(var.settings) : contains(
          [
            "base_tags",
            "enable_advanced_threat_protection_settings",
            "enable_security_alert_policies",
            "is_source_database_deleted",
            "long_term_retention_policy",
            "mi_server_key",
            "name",
            "properties",
            "short_term_retention_days",
            "tags",
            "version"
          ], k
        )
      ]
    )
    error_message = format("The following attributes are not supported. Adjust your configuration file: %s", join(", ",
      setsubtract(
        keys(var.settings),
        [
          "base_tags",
          "enable_advanced_threat_protection_settings",
          "enable_security_alert_policies",
          "is_source_database_deleted",
          "long_term_retention_policy",
          "mi_server_key",
          "name",
          "properties",
          "short_term_retention_days",
          "tags",
          "version"
        ]
      )
      )
    )
  }
}

