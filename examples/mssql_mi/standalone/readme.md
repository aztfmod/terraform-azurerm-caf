You can test this module outside of a landingzone using

```bash
terraform init

terraform [plan|apply|destroy] \ 
  -var-file ../200-mi-two-regions/configuration.tfvars \ 
  -var-file ../200-mi-two-regions/nsg.tfvars \


```
