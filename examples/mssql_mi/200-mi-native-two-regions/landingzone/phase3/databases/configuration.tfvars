
landingzone = {
  backend_type        = "azurerm"
  level               = "level1"
  key                 = "databases"
  global_settings_key = "sqlmi1"

  tfstates = {
    sqlmi1 = {
      tfstate = "sqlmi-sqlmi1.tfstate"
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
