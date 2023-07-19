variable "settings" {
  type    = any
  default = {}
}

variable "profile_id" {
  type    = any
  default = {}
}

variable "target_resource_id" {
  type    = any
  default = {}
}

variable "remote_objects" {
  type        = any
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}
