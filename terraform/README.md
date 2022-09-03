# Terraform

## Description

This Terraform module is used to provision the GCP infrastructure required to expose the prediction API.

Enables the following APIs:
- run.googleapis.com
- iam.googleapis.co
- cloudbuild.googleapis.com

Creates the following infraesture:

- A service account called "flight-prediction-worker" with the "roles/run.invoker" role.
- A Cloud Run Service using the API image.

## Structure  

The Terraform module consist in the following configuration files: 

```bash
└── terraform
    ├── scripts
    │   └── get_latest_tag.sh
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── project.tf
    ├── run_service.tf
    └── README.md
```

* `main.tf` - the main Terraform file
* `variables.tf` - declares variables
* `outputs.tf` - declares outputs
* `project.tf` - the GCP required APIs that need to be enabled in the project, including the IAM service account
* `run_service.tf` - the Cloud Run service
* `scripts/get_latest_tag.sh` - script used by the terraform manifest to get the latest prediction API image from the Container Registry in order to create the Cloud Run service