
landingzone = {
  backend_type        = "azurerm"
  level               = "level1"
  key                 = "restore"
  global_settings_key = "phase1"

  tfstates = {
    phase1 = {
      tfstate = "sqlmi-phase1.tfstate"
    }
  }
}

# For CI:
# tfstate value is based on:
# format(%s-%s.tfstate, [value of the scenario], 'phase1')
#
# ci file .github/workflows/landingzone-scenarios.yaml
#
# {
#   "config_files":[
#     {
#       "scenario": "sqlmi",
#       "phases": {
#         "phase1": "mssql_mi/200-mi-native-two-regions/landingzone/phase1",
#         "phase2": "mssql_mi/200-mi-native-two-regions/landingzone/phase2"
#       }

#     }
#   ]
# }
