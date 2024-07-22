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
    app_roles = {
      admin = {
        allowed_member_types = ["User"]
        description          = "Admin"
        display_name         = "Admin"
        value                = "Admin"
      }
      viewer = {
        allowed_member_types = ["User"]
        description          = "Viewer"
        display_name         = "Viewer"
        value                = "Viewer"
      }
    }
  }
}
