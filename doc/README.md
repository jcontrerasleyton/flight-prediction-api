# Cloud based flight delay prediction API

## Assumptions

These are the assumptions and decisions made for the design and development of this project:

- It is assumed that the API is exposed to the general public.
- The model is assumed to be serialized and does not need to be retrained.
- The model only performs a single flight delay prediction per API request.
- API users know the request format in advance.
- Selection of GCP over other cloud services is due to familiarity with the platform.
- Cloud Run is selected over Cloud Functions for the API deployment, taking into consideration that the former is capable of handling multiple requests at a time, while the latter only handles one request at a time.

---

## Model

The model, corresponding to a Logistic Regression model, predicts a categorical variable whose values can be 1 (delay) or 0 (no delay).

The input consists of a feature vector (of size 37) whose values can be 0 or 1. This vector describes a particular flight and is used to perform the prediction.

This model was selected after being compared to an XGBoost model and obtaining higher performance and a much shorter processing time.

---

## Architecture

![Architecture diagram](/media/architecture.png)

The Continuous Integration and Continuous Delivery Pipeline for this project is the following:

- First, Cloud Build is used to build and push a Python 3.7 based image to the GCP Container Registry, which wraps the Rest API and exposes it with a Gunicorn WSGI HTTP Server.

- Then, a Terraform manifest is applied to enable the required APIs, create the Cloud Run service (sourcing the latest pushed image from the Container Registry), and configure the IAM needed permissions throughout the automation.

---

## Improvement and Future Work

### Security

- Upload the source code to the organization's internal repository so it is not exposed to the general public.

### Pipeline

- Use Jenkins, Bamboo, or another automation server for the CICD pipeline.

- Create two Jobs, one for build and one for deployment:

    - The build job will be in charge of the following:

        - Download the API source code
        - Perform unit tests
        - Perform a static code scan using Sonarqube
        - Perform a vulnerability scan using Veracode
        - Build the API Docker image and upload it to the Container Registry

    - The deployment job will be in charge of the following:

        - Deploy the necessary infrastructure in GCP using Terraform