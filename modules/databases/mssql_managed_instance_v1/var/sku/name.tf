variable "name" {
  description = "Managed instance SKU. Allowed values for sku.name: GP_Gen5, GP_G8IM, GP_G8IH, BC_Gen5, BC_G8IM, BC_G8IH"

  validation {
    condition = contains(
      [
        "GP_Gen4", "GP_Gen5", "GP_Gen8IM", "GP_Gen8IH", "BC_Gen4", "BC_Gen5", "BC_Gen8IM", "BC_Gen8IH"
      ],
      var.name
    )
    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value: %s",
      var.name,
      join(", ",
        [
          "GP_Gen4", "GP_Gen5", "GP_Gen8IM", "GP_Gen8IH", "BC_Gen4", "BC_Gen5", "BC_Gen8IM", "BC_Gen8IH"
        ]
      )
    )
  }
}
output "name" {
  value = var.name
}
#