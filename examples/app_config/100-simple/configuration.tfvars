global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
}

resource_groups = {
  rg1 = {
    name   = "rg1"
    region = "region1"
  }
}

app_config = {
  appconf1 = {
    name               = "appConf1"
    resource_group_key = "rg1"
    location           = "region1"
  }
}

app_config_entries = {
  key = "appconf1"
  #lz_key = ""

  settings = {
    foo = {
      value = 1
      label = "label1"
    }
    bar = {
      value = "hello world"
    }
  }

  # You can store attributes of other resources as settings, e.g. the client_id of a managed
  # identity. Only works in a landing zone type deploy.
  #dynamic_settings = {
    #msi_client_id = {
      #managed_identities = {
        #level0 = {
          #lz_key =        "launchpad"
          #attribute_key = "client_id"
          #label =         "label2"
        #}
      #}
    #}
  #}
}
