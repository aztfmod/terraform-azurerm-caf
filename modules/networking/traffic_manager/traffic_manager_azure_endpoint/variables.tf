variable "settings" {
  default = {}
}

variable "profile_id" {
  default = {}
}

variable "target_resource_id" {
  default = {}
}

variable "remote_objects" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}