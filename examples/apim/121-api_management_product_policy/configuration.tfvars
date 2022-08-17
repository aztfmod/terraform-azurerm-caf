global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
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
    name   = "example-apim"
    region = "region1"
    resource_group = {
      key = "rg1"
    }
    publisher_name  = "My Company"
    publisher_email = "company@terraform.io"

    sku_name = "Developer_1"
  }
}

api_management_product = {
  apimprod1 = {
    resource_group = {
      key = "rg1"
    }
    api_management = {
      key = "apim1"
    }
    name                  = "example-product"
    subscription_required = true
    approval_required     = false
    published             = true
    display_name          = "Example PRODUCT"
  }
}

api_management_product_policy = {
  apimprodpol1 = {
    resource_group = {
      key = "rg1"
    }
    api_management = {
      key = "apim1"
    }
    product = {
      key = "apimprod1"
    }
    xml_content = <<XML
    <policies>
      <inbound>
        <find-and-replace from="xyz" to="abc" />
      </inbound>
    </policies>
    XML
  }
}