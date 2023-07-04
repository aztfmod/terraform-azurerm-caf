global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
  }
}

resource_groups = {
  rg1 = {
    name   = "powerbi"
    region = "region1"
  }
}

powerbi_embedded = {
  powerbi_re1 = {
    name               = "examplepowerbi"
    region             = "region1"
    resource_group_key = "rg1"
    sku_name           = "A1" # Possible values include: A1, A2, A3, A4, A5, A6.
    administrators     = ["foo@example.com"]
    # mode               = "Gen1" # Gen1 | Gen2 (Defaults to Gen1)
    # tags               = {} # optional
  }
}



