
landingzone = {
  backend_type        = "azurerm"
  level               = "level1"
  key                 = "sqlmi3"
  global_settings_key = "sqlmi1"

  tfstates = {
    sqlmi1 = {
      tfstate = "sqlmi-sqlmi1.tfstate"
    }
  }
}

# For CI:
# tfstate value is based on:
# format(%s-%s.tfstate, [value of the scenario], 'sqlmi1')
#
# ci file .github/workflows/landingzone-scenarios.yaml
#
# {
#   "jobs":[
#     {
#       "name": "sqlmi",
#       "lz_ref": "int-5.7.0",
#       "phase1": [
#         {
#           "name": "sqlmi1",
#           "path": "mssql_mi/200-mi-native-two-regions/landingzone/phase1/sqlmi1"
#         }
#       ],
#       "phase2": [
#         {
#           "name": "sqlmi2",
#           "path": "mssql_mi/200-mi-native-two-regions/landingzone/phase2/sqlmi2"
#         },
#         {
#           "name": "sqlmi3",
#           "path": "mssql_mi/200-mi-native-two-regions/landingzone/phase2/sqlmi3"
#         }
#       ]
#     }
#   ]
# }

