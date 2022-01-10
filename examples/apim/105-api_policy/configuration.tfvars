global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-agw"
    region = "region1"
  }
}


api_management = {
  apim1 = {
    name                = "example-apim"
    region              = "region1"
    resource_group      = {
      key = "rg1"
    }
    publisher_name      = "My Company"
    publisher_email     = "company@terraform.io"

    sku_name = "Developer_1"
  }
}
api_management_api = {
  apimapi1 = {
    name                = "example-api"
    resource_group      = {
      key = "rg1"
    }
    api_management_key = "apim1"
    revision            = "1"
    display_name        = "Example API"
    path                = "example"
    protocols           = ["https"]

    import = {
      content_format = "swagger-link-json"
      content_value  = "http://conferenceapi.azurewebsites.net/?format=json"
    }
  }
}
api_management_api_policy = {
    
    api = {
      key            = "apimapi1"
    }
    api_management = {
      key = "apim1"
    }
    resource_group      = {
      key = "rg1"
    }
    operation_id        = "user-delete"
  xml_content = <<XML
<policies>
  <inbound>
    <find-and-replace from="xyz" to="abc" />
  </inbound>
</policies>
XML

}