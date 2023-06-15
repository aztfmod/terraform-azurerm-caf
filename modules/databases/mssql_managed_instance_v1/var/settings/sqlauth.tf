variable "authentication_mode" {
  description = "Authentication mode for SQL. Allowed Values: sql_only,aad_only,hybrid"
  nullable    = true

  validation {
    condition = contains(
      [
        "sql_only",
        "hybrid",
        "aad_only"
      ],
      var.authentication_mode
    )
    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value: %s",
      var.authentication_mode == null ? "null" : var.authentication_mode,
      join(", ",
        [
          "sql_only",
          "hybrid",
          "aad_only"
        ]
      )
    )
  }
}
output "authentication_mode" {
  value = var.authentication_mode
}

#
