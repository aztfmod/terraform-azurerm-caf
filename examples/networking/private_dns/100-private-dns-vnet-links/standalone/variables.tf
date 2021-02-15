variable global_settings {
  default = {}
}

variable resource_groups {
  default = null
}


variable vnets {
  default = {}
}

variable private_dns {
  default = {}
}


variable tags {
  default = null
  type    = map
}

variable logged_aad_app_objectId {
  default = {}
}