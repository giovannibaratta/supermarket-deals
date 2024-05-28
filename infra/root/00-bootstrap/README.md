# Bootstrap

## Initial setup

If it is the first time that you apply this code, remove any existent backend configuration for Terraform. The code will automatically generate the backend configuration that must be used during subsequent runs. After successfully applying this module, run the following command to migrate the state to the remote bucket.

```bash
terraform init -migrate-state
```
