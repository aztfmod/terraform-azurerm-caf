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
    public_client = {
      redirect_uris = ["http://localhost:8080"]
    }
  }
}
