# Defines the different destination for the different log profiles
# Different profiles to target different operational teams

diagnostics_destinations = {
  # Storage keys must reference the azure region name
  # For storage, reference "all_regions" and we will send the logs to the storage account
  # in the region of the deployment
  storage = {
    all_regions = {
      global = {
        storage_account_key = "diagnostics_region1"
      }
    }
  }
}
