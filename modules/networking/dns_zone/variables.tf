
variable resource_group_name {
  description = "(Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
}

variable location {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable settings {}
variable global_settings {}
variable base_tags {}
variable contract {}
variable tags {}
variable name {
  description = "(Required) Name of the Domain to be created"
  type        = string
  default     = "terra.com"
}

# variable contract {
#   description = "(Required) contract fields for the domain name registration"
#   type = object({
#     name_first  = string
#     name_last   = string
#     email       = string
#     phone       = string
#     job_title   = string
#     address1    = string
#     address2    = string
#     postal_code = string
#     state       = string
#     city        = string
#     country     = string
#     auto_renew  = bool
#   })
# }

variable lock_zone {
  description = "(Required) Determines to put a Azure lock after creating the zone"
  type        = bool
  default     = false
}

variable lock_domain {
  description = "(Required) Determines to put a Azure lock after create the domain"
  type        = bool
  default     = false
}