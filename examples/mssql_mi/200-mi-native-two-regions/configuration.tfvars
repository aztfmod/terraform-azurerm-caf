global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
    region2 = "japaneast"
  }
}

resource_groups = {
  networking_region1 = {
    name   = "sqlmi-networking-re1"
    region = "region1"
  }
  networking_region2 = {
    name   = "sqlmi-networking-re2"
    region = "region2"
  }
  sqlmi_region1 = {
    name   = "sqlmi-db-re1"
    region = "region1"
  }
  sqlmi_region2 = {
    name   = "sqlmi-db-re2"
    region = "region2"
  }
}
