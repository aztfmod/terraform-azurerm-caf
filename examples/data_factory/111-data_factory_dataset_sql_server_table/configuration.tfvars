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

data_factory_linked_service_sql_server = {
  dflsss1 = {
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
    connection_string = "Integrated Security=False;Data Source=test;Initial Catalog=test;User ID=test;Password=test"
  }
}

data_factory_dataset_sql_server_table = {
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
      key = "dflsss1"
      #lz_key = ""
      #name = ""
    }
  }
}

