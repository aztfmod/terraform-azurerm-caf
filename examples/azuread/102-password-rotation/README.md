You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/azuread/102-password-rotation

# Replace the ci number to identify
./standalone/ci.sh 32321321

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/landingzones/caf_example \
  -var-folder  /tf/caf/examples/azuread/102-password-rotation \
  -level level1 \
  -a [plan | apply | destroy]

```