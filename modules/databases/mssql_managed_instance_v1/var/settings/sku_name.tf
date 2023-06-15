variable "sku_name" {
  description = <<DESC
  Set the sku object with the following structure:

  sku = {
    name     = "GB_Gen5"
  }

  DESC
  default     = "GP_Gen5"
  nullable    = false

  validation {
    condition = contains(
      [
        "BC_Gen4",
        "BC_Gen5",
        "BC_Gen8IH",
        "BC_Gen8IM",
        "GP_Gen4",
        "GP_Gen5",
        "GP_Gen8IH",
        "GP_Gen8IM"
      ],
      var.sku_name
    )
    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value: %s",
      var.sku_name,
      join(", ",
        [
          "BC_Gen4",
          "BC_Gen5",
          "BC_Gen8IH",
          "BC_Gen8IM",
          "GP_Gen4",
          "GP_Gen5",
          "GP_Gen8IH",
          "GP_Gen8IM"
        ]
      )
    )
  }


}
output "sku_name" {
  value = var.sku_name
}
#