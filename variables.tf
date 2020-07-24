# # Map of the remote data state for lower level
# variable lowerlevel_storage_account_name {}
# variable lowerlevel_container_name {}
# variable lowerlevel_key {} # Keeping the key for the lower level0 access
# variable lowerlevel_resource_group_name {}
# variable workspace {}

# Global settings 
variable prefix {
  default = ""
}
variable prefix_with_hyphen {}
variable global_settings {}
variable caf_foundations_security {}
variable caf_foundations_accounting {}

variable tags {
  type = map
  default = {}
}

variable resource_groups {
  description = "Name of the existing resource group to deploy the virtual machine"
}

variable location {
  description = "Location to deploy the resources"
  default = ""
}

## Compute variables
variable virtual_machines {
  description = "Virtual machine object"
  default = {}
}

## Networking variables
variable networking {
  default = {}
}

variable vnets {
  description = "Represent an already deployed vnet output by another landingzone"
  default = {}
}

variable firewall {
  default = {}
}

## Security variables
variable managed_identities {
  default = {}
}

## Storage variables
variable storage_accounts {
  default = {}
}