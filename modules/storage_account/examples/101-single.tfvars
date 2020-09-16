resource_groups = {
  test_sg = {
    name      = "test-caf_storage_account-sg"
    location  = "southeastasia"
    useprefix = true
  }
}

storage_accounts = {
  media = {
    name               = "media"
    resource_group_key = "test_sg"
  }
}