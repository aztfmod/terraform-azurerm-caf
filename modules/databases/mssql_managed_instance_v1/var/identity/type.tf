variable "type" {
  description = "Managed Identity Type : SystemAssigned , UserAssigned"

  validation {
    condition = contains(
      [
        "SystemAssigned", "UserAssigned"
      ],
      var.type
    )
    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value: %s",
      var.type,
      join(", ",
        [
          "SystemAssigned", "UserAssigned"
        ]
      )
    )
  }
}
output "type" {
  value = var.type
}
