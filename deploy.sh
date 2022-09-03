#!/bin/sh

project_id=$1 

if gcloud projects describe $project_id
then
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
else
    echo "Proyecto $project_id no existe"
fi