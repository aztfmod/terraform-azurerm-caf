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

data_factory_linked_service_web = {
  dflsw1 = {
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
    authentication_type = "Anonymous"
    url                 = "https://www.bing.com"
  }
}
data_factory_dataset_delimited_text = {
  dfddt1 = {
    name = "example"
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
      key = "dflsw1"
      #lz_key = ""
      #name = ""
    }

    http_server_location = {
      relative_url = "http://www.bing.com"
      path         = "foo/bar/"
      filename     = "fizz.txt"
    }

    column_delimiter    = ","
    row_delimiter       = "NEW"
    encoding            = "UTF-8"
    quote_character     = "x"
    escape_character    = "f"
    first_row_as_header = true
    null_value          = "NULL"
  }
}