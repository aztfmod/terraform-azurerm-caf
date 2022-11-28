# Deployment Note
Due to the interdependence of mssql server, kv access policy and enablement of TDE, the sequence of deployment is as below
1. Leave TDE enablement = false as it will not work until server gets key management access to the KV
2. Once mssql server is created and assigned to the group membership in the first run, enable the TDE and re-run
