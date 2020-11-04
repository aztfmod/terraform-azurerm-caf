variable global_settings {}
variable name {
  description = "(Required) Name of the Azure Firewall to be created"
}

variable location {
  description = "(Required) Location of the Azure Firewall to be created"
}

variable tags {
  description = "(Required) Tags of the Azure Firewall to be created"
}

variable resource_group_name {
  description = "(Required) Resource Group of the Azure Firewall to be created"
}

variable subnet_id {
  description = "(Required) ID for the subnet where to deploy the Azure Firewall "
}

variable public_ip_id {
  description = "(Required) Public IP address identifier. IP address must be of type static and standard."
}

variable diagnostics {
  default = {}
}
variable settings {}

variable diagnostic_profiles {
  default = {}
}

variable base_tags {}