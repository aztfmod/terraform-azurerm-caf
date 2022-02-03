global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  evg_examples = {
    name   = "eventgrid"
    region = "region1"
  }
}

eventgrid_topics = {
  egt1 = {
    name               = "egt1"
    resource_group_key = "evg_examples"
    region             = "region1"
    tags = {
      Contributor = "Bravent"
    }
  }
}