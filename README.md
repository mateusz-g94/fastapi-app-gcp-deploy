## Description
Infrastructure for deployment simple FastAPI application to GCP cloud.

## How to apply

1. Enable gcloud services
```
gcloud services enable servicenetworking.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud services enable containerregistry.googleapis.com 
gcloud services enable run.googleapis.com 
gcloud services enable sourcerepo.googleapis.com    
gcloud services enable compute.googleapis.com
```

2. Push initial image to GCP
https://github.com/mateusz-g94/fastapi-app

3. Update config file named config.yaml in [workspace] folders  

4. Terraform 

``` {terraform}
terraform init
terraform workspace new [workspace]
terraform workspace select [workspace]
terraform plan
terraform apply 
```

Additional Info:
- Available workspaces: ws-dev-us-east1, ws-dev-europe-west1, ws-prd-us-east1, ws-prd-europe-west1
- assumption: the backend bucket is created
- assumption: access keys are exported with all permissions and rols
- module ./modules/observabiliti initial author: https://github.com/AckeeCZ/terraform-gcp-prometheus-to-monitoring - I upgraded and costumize this module for my own need (change in cloud function go code)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.67.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.67.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 4.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_metrics_push"></a> [metrics\_push](#module\_metrics\_push) | ./modules/observability | n/a |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_api_gateway_api.api_gw](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_api_gateway_api) | resource |
| [google-beta_google_api_gateway_api_config.api_gw_con](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_api_gateway_api_config) | resource |
| [google-beta_google_api_gateway_gateway.gw](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_api_gateway_gateway) | resource |
| [google_cloud_run_service.service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service) | resource |
| [google_cloud_run_service_iam_member.apigw_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_member) | resource |
| [google_cloud_run_service_iam_member.function_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_member) | resource |
| [google_cloudbuild_trigger.cloud_build_trigger](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger) | resource |
| [google_monitoring_dashboard.dashboard](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_dashboard) | resource |
| [google_service_account.service_account_apigw](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_endpoint"></a> [public\_endpoint](#output\_public\_endpoint) | service hostname endpoint for ai application. |
<!-- END_TF_DOCS -->