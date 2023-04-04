# variable "administrators" {
#   description = <<DESC
#   Set the sku object with the following structure:

# administrators = {
#       azuread_only_authentication = false
#       sid                         = "objectguid"
#       login                       = "principal displayname"
#       tenantId                    = "tenantidguid"
#     }

#   DESC
#   default     = null

#   type = object(
#     {
#       azuread_only_authentication = bool
#       sid                         = string
#       login                       = string
#       tenantId                    = optional(string)
#     }
#   )


# }

# output "administrators" {
#   value = var.administrators
# }
# #