global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  aks_re1 = {
    name   = "aksagw"
    region = "region1"
  }
}

managed_identities = {
  aks_usermsi = {
    name               = "aksagw-msi01"
    resource_group_key = "aks_re1"
  }
}