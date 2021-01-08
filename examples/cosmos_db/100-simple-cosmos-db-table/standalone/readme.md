You can test this module outside of a landingzone using

```bash
terraform init

terraform [plan|apply|destroy] \
  -var-file ../tables.tfvars
```
