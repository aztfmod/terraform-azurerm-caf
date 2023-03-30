variable "principal_type" {
  description = "Managed instance SKU. Allowed values for sku.name: GP_Gen5, GP_G8IM, GP_G8IH, BC_Gen5, BC_G8IM, BC_G8IH"
  nullable    = true
  validation {
    condition = contains(
      [
        "Application", "Group", "User"
      ],
      var.principal_type
    )
    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value: %s",
      var.principal_type == null ? "null" : var.principal_type,
      join(", ",
        [
          "Application", "Group", "User"
        ]
      )
    )
  }
}
output "principal_type" {
  value = var.principal_type
}
#