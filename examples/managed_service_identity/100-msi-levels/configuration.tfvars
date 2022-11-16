
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  msi_region1 = {
    name   = "security-rg1"
    region = "region1"
  }
}

managed_identities = {
  level0 = {
    # Used by the release agent to access the level0 keyvault and storage account with the tfstates in read / write
    # Assign read access to level0
    name = "msi-level0"
    resource_group = {
      # lz_key = "examples"
      key = "msi_region1"
    }
    # resource_group_key will be deprecated in the future
    # resource_group_key = "msi_region1"
    tags = {
      level = "level0"
    }
  }
  level1 = {
    # Used by the release agent to access the level1 keyvault and storage account with the tfstates in read / write
    # Assign read access to level0
    name = "msi-level1"
    resource_group = {
      # lz_key = "examples"
      key = "msi_region1"
    }
    # resource_group_key will be deprecated in the future
    # resource_group_key = "msi_region1"
    tags = {
      level = "level1"
    }
  }
  level2 = {
    # Used by the release agent to access the level2 keyvault and storage account with the tfstates in read / write
    # Assign read access to level1
    name = "msi-level2"
    resource_group = {
      # lz_key = "examples"
      key = "msi_region1"
    }
    # resource_group_key will be deprecated in the future
    # resource_group_key = "msi_region1"
    tags = {
      level = "level2"
    }
  }
  level3 = {
    # Used by the release agent to access the level3 keyvault and storage account with the tfstates in read / write
    # Assign read access to level2
    name = "msi-level3"
    resource_group = {
      # lz_key = "examples"
      key = "msi_region1"
    }
    # resource_group_key will be deprecated in the future
    # resource_group_key = "msi_region1"
    tags = {
      level = "level3"
    }
  }
  level4 = {
    # Used by the release agent to access the level4 keyvault and storage account with the tfstates in read / write
    # Assign read access to level3
    name = "msi-level4"
    resource_group = {
      # lz_key = "examples"
      key = "msi_region1"
    }
    # resource_group_key will be deprecated in the future
    # resource_group_key = "msi_region1"
    tags = {
      level = "level4"
    }
  }
}
