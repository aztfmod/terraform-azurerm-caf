#
# Global settings
#
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

#
# Resource groups to be created
#
resource_groups = {
  dms = {
    name   = "database-migration-re1"
    region = "region1"
  }
}


vnets = {
  vnet_region1 = {
    resource_group_key = "dms"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.100.0/29"]
      }
    }

  }
}

database_migration_services = {
  dmstest = {
    name               = "test-dms"
    resource_group_key = "dms"
    region             = "region1"
    sku_name           = "Premium_4vCores"
    subnet = {
      vnet_key   = "vnet_region1"
      subnet_key = "example"
      #lz_key
      #subnet_id
    }
  }
}

database_migration_projects = {
  project1 = {
    name               = "project1"
    resource_group_key = "dms"
    region             = "region1"
    service = {
      key = "dmstest"
      #name
      #lz_key
    }
    source_platform = "SQL"
    target_platform = "SQLDB"
  }
}