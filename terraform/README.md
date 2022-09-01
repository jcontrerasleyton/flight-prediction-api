# Terraform

## Description

This Terraform module is used to provision the GCP infrastructure required to expose the prediction API.

## Structure  

The Terraform module consist in the following configuration files: 

* `main.tf` - the main Terraform file
* `variables.tf` - declares variables
* `outputs.tf` - declares outputs
* `project.tf` - the GCP required APIs that need to be enable, including the IAM service account
* `run_service.tf` - the Cloud Run service
* `scripts/get_latest_tag.sh` - script used by the terraform manifest to get the latest prediction API image from Container Registry in order to create the Cloud Run service