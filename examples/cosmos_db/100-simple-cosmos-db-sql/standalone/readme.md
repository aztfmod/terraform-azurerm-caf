You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/cosmos_db/100-simple-cosmos-db-sql/standalone

terraform init

terraform [plan | apply | destroy]\
  -var-file ../sql_databases.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/landingzones/caf_example \
  -var-folder  /tf/caf/examples/cosmos_db/100-simple-cosmos-db-sql/ \
  -level level1 \
  -a [plan | apply | destroy]

```