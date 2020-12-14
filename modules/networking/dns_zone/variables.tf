variable resource_group_name {}
variable location {}
variable settings {}
variable global_settings {}
variable base_tags {}
variable contract {
  default = {}
}
variable name {
  description = "(Required) Name of the Domain to be created"
  type        = string
  default     = "terra.com"
}

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