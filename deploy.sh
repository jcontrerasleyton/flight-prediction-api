#!/bin/sh

project_id=$1 

#Set project ID
gcloud config set project $project_id

#Enable CloudBuild API
gcloud services enable cloudbuild.googleapis.com

#Build the API service container
gcloud builds submit

#Initialize and apply the Terraform manifests
cd terraform
terraform init 
terraform apply -var="project=$project_id" -auto-approve