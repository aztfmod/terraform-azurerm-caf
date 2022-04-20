# ------------------------ Public IP Prefixes in each region --------------------------------
public_ip_prefixes = {

  example_pipp1_re1 = {
    name               = "example-pipp1"
    resource_group_key = "pipp_re1"
    region             = "region1"
    sku                = "Standard"       # (Optional) The SKU of the Public IP Prefix. Accepted values are Standard. Defaults to Standard
    zones              = "Zone-Redundant" # (Optional) The availability zone to allocate the Public IP in. Possible values are Zone-Redundant, 1, 2, 3, and No-Zone. Defaults to Zone-Redundant.
    ip_version         = "IPv4"
    prefix_length      = 31 # (Optional) Specifies the number of bits of the prefix. The value can be set between 0 (4,294,967,296 addresses) and 31 (2 addresses). Defaults to 28(16 addresses). Changing this forces a new resource to be created.
    tags               = { locked = true }
  }
}

# ------------------------ Public IP from public ip prefix ----------------------------------
public_ip_addresses = {

  example_pip1_re1 = {
    name                    = "example-pip1-re1"
    resource_group_key      = "pipp_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    domain_name_label       = "example-pipp1" # Result will be: <domain_name_label>.<region>.cloudapp.azure.com,
    tags                    = { locked = true }
    zones                   = "Zone-Redundant"
    idle_timeout_in_minutes = "4"
    public_ip_prefix = {
      # lz_key = 
      key = "example_pipp1_re1"
    }
  }

  example_pip2_re1 = {
    name                    = "example-pip2-re1"
    resource_group_key      = "pipp_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    domain_name_label       = "example-pipp2" # Result will be: <domain_name_label>.<region>.cloudapp.azure.com,
    tags                    = { locked = true }
    zones                   = "Zone-Redundant"
    idle_timeout_in_minutes = "4"
    public_ip_prefix = {
      # lz_key = 
      key = "example_pipp1_re1"
    }
  }
  #  diagnostic_profiles = {
  #    central_logs_region1 = {
  #      definition_key   = "public_ip_address"
  #      destination_type = "log_analytics"
  #      destination_key  = "central_logs"
  #    }
  #  }
}
