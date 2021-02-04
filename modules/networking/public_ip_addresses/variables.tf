variable name {}
variable resource_group_name {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable location {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable sku {
  default = "Basic"
}
variable allocation_method {
  default = "Dynamic"
}
variable ip_version {
  default = "IPv4"
}
variable idle_timeout_in_minutes {
  default = null
}
variable domain_name_label {
  default = null
}
# if set to true, automatically generate a domain name label with the name
variable generate_domain_name_label {
  default = false
}
variable reverse_fqdn {
  default = null
}
variable tags {
  default = null
}
variable zones {
  default = null
}
variable diagnostics {
  default = {}
}
variable diagnostic_profiles {
  default = {}
}
variable base_tags {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map
}