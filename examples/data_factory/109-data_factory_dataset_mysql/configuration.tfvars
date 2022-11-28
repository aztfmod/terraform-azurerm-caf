global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}
resource_groups = {
  rg1 = {
    name   = "databricks-re1"
    region = "region1"
  }
}
data_factory = {
  df1 = {
    name = "example"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
  }
}
data_factory_linked_service_mysql = {
  dflsmysql1 = {
    name = "dflsabs1example"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
    data_factory = {
      key = "df1"
      #lz_key = ""
      #name = ""
    }
    connection_string = "Server=test;Port=3306;Database=test;User=test;SSLMode=1;UseSystemTrustStore=0;Password=test"
  }
}

data_factory_dataset_mysql = {
  dfdab1 = {
    name = "dfdab1example"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
    data_factory = {
      key = "df1"
      #lz_key = ""
      #name = ""
    }
    linked_service = {
      key = "dflsmysql1"
      #lz_key = ""
      #name = ""
    }
  }
}

