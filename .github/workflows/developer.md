
You can test the workflows on your local machine

## MacOS

Install [Act](https://github.com/nektos/act) to run Github workflows on your local machine

```bash
brew install act
```

From the root of the module:

```bash
# Make sure you have a GH_TOKEN with repo and workflow privileges
export GH_TOKEN="$(gh auth token)"

act --container-architecture linux/arm64 \
  -s GITHUB_TOKEN=$GITHUB_TOKEN \
  -s ARM_CLIENT_ID=$ARM_CLIENT_ID \
  -s ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET \
  -s ARM_TENANT_ID=$ARM_TENANT_ID  \
  -s ARM_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID \
  -P ubuntu-latest=catthehacker/ubuntu:act-latest \
  -W .github/workflows/landingzone-scenarios.yaml \
  --input scenario=landingzone-scenarios-longrunners.json \
  workflow_dispatch
```