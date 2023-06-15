variable "administrator_login" {
  description = "(Required) The administrator login name for the new SQL Managed Instance. Changing this forces a new resource to be created."
}
output "administratorLogin" {
  value = var.administrator_login
}

variable "administrator_login_password" {
  description = "(Required) The password associated with the administrator_login user. Needs to comply with Azure's Password Policy - https://msdn.microsoft.com/library/ms161959.aspx"
}
output "administratorLoginPassword" {
  value = var.administrator_login_password
}


variable "keyvault" {
  description = "(Required) - Keyvault to store the sqlmi administrator password."
  validation {
    condition = alltrue(
      [
        for k, v in var.keyvault : contains(
          [
            "id",
            "key",
            "lz_key"
          ], k
        )
      ]
    )
    error_message = format("The following attributes are not supported. Adjust your configuration file: %s", join(", ",
      setsubtract(
        keys(var.keyvault),
        [
          "id",
          "key",
          "lz_key"
        ]
      )
      )
    )
  }
}
output "keyvault" {
  value = var.keyvault
}
#