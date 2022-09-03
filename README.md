# Cloud based flight delay prediction API
## Description

The Flight Delay Prediction API is a Rest API solution developed in Python. It exposes a machine learning model that has been trained to predict the probability of delays from flights landing or taking off from the Santiago de Chile Airport (SCL). This API is then automatically deployed to the Google Cloud Platform (GCP) using Terraform.

---

## How to use

### Clone Project

 * Create a new project on Google Cloud with [billing enabled](https://cloud.google.com/billing/docs/how-to/modify-project), and launch [Cloud Shell](https://cloud.google.com/shell/docs/using-cloud-shell).

 * Clone this repo:

    ```bash
    git clone https://github.com/jcontrerasleyton/flight-prediction-api
    cd flight-prediction-api
    ```

 * Execute the pipeline using a [script](#deploy-with-a-script) or [step by step](#deploy-step-by-step) (manually).
### Deploy with a script

Use this option if you want to execute the entire pipeline at once:

  * Run deployment script:

    ```bash
    ./deploy.sh your_project_id
    ```

  * At the end of the execution a link to the API endpoint will appear, use this URL to send REST requests.

    ![Endpoint](/media/endpoint.png)

### Deploy step by step

Use this option is you want to execute one command at a time:

 * Create a new project on Google Cloud with [billing enabled](https://cloud.google.com/billing/docs/how-to/modify-project), and launch [Cloud Shell](https://cloud.google.com/shell/docs/using-cloud-shell).

 * Clone this repo:

    ```bash
    git clone https://github.com/jcontrerasleyton/flight-prediction-api
    cd flight-prediction-api
    ```

  * Set project ID:

    ```bash
    gcloud config set project your_project_id
    ```

  * Enable CloudBuild API:

    ```bash
    gcloud services enable cloudbuild.googleapis.com
    ```

  * Build the API service container:

    ```bash
    gcloud builds submit
    ```

  * Initialize and apply the Terraform manifests: 

    ```bash
    cd terraform
    terraform init 
    terraform apply -var="project=your_project_id" -auto-approve
    ```

  * At the end of the execution a link to the API endpoint will appear, use this URL to send REST requests.

    ![Endpoint](/media/endpoint.png)

---

See [DOC](doc/README.md) for more details of Assumptions, Model and Arquitecture.

See [API](api/README.md) for more details of the API implementation.

See [Terraform](terraform/README.md) for more details of the Terraform implementation.