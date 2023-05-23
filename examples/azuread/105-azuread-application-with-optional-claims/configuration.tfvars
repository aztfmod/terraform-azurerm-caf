global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  random_length = 5
}

azuread_applications = {
  test_client = {
    useprefix        = true
    application_name = "test-client"
    optional_claims = {
      access_token = {
        aud = {
          name = "aud"
        }
      }
      id_token = {
        sid = {
          name = "sid"
        }
      }
      id_token = {
        userclaim = {
          name                  = "userclaim"
          source                = "user"
          essential             = true
          additional_properties = ["emit_as_roles"]
        }
      }
    }
  }
}
