# Cloud based flight delay prediction API

## Assumptions and Decisions

These are the assumptions and decisions made for the design and development of this project:

### Assumptions

- The GCP project was created and has billing enabled.
- The API is exposed to the general public.
- The model is assumed to be serialized and does not need to be retrained.
- API users know the request format in advance, so there is no need for data validation.
- It is assumed that the API has no bugs, so the Unit tests will not be implemented.
- The model only performs a single flight delay prediction per API request.
- For the deployment, the developer should access Cloud Shell in the target project, clone this repository and execute the required commands.

### Decisions

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

## SLI and SLO 

## Service Level Indicators (SLI)

For this project, the SLI is the following:

- 95th percentile of successful requests whose latency is lower than 300ms
- 99th percentile of successful requests whose latency is lower than 550ms

This metric was chosen considering the results delivered by the stress test, where, on average, the latency is less than 300ms. In addition, when reviewing the historical data of the API service in Cloud Run, the 95 percentile has a latency of less than 300ms and the 99 percentile has a latency of less than 550ms, regardless of the number of requests. 

![cloudRun](/media/cloud_run.png)

## Service Level Objectives (SLO)

For this project, the SLO is the following:

- 95% of requests with latency lower than 300ms over a month
- 99% of requests with latency lower than 550ms over a month

The time window was chosen because it is neither as small as a week nor as large as a semester or year.

If it were weekly, this would imply weekly analyzes on the SLO and considering that there can be many models being exposed at the same time, it would become unmanageable.

On the other hand, if it were a semester or year window, it would be a long time before course-correcting decisions can be made in SLO-related issues.

---

## Improvement and Future Work

The improvements and considerations that must be applied to the current implementation in order to guarantee security, performance, quality and reliability are described below.

### Quality

- Implement data validation to the JSON input, with the following restrictions:
    - Type: String
    - Length: 73
    - Characters: 36 commas (",")
    - Digits: 37 with values 0 or 1

- Implement Unit Tests with [Unittest](https://docs.python.org/3/library/unittest.html) or [Pytest](https://docs.pytest.org/en/7.1.x/).

### Security

- Upload the source code to the organization's internal repository so it is not exposed to the general public.

- Limit access to the Cloud Run service on GCP to only authorized users using IAM groups and fine-grained roles (roles/run.invoker) in the Terraform module "google_iam_policy".

- Limit Cloud Run ingress traffic [settings](https://cloud.google.com/run/docs/securing/ingress) based on requests origin:

    - **Internal**: requests are expected from GCP resources and On-Prem resources connected to a VPC via Cloud VPN.
    - **Internal and Cloud Load Balancing**: request from GCP resources and External HTTP(S) load balancer.
    - **All**: requests are expected from everywhere.

- If request are not Internal, change the Cloud Run authentication settings to *Require Authentication* and use the [JWT](https://jwt.io/introduction) authorization standard:

    - JSON Web Token (JWT) is an open standard for the creation of access tokens.
    
    - Only requests that contain a signed JSON Web Token are granted access to the API. In other words, only authorized systems can access the API.

    - One advantage is that is harder to impersonate a user because the token needs to be signed unlike others API token solutions.

    - Take in mind that his has an impact in latency due to the token decode and verification process.

- Another authorization option is [OAuth (2.0)](https://auth0.com) wich also creates access tokens and has third party integration (so authorized users can access the API with a third party account).
    
    - OAuth (2.0) can be used for authentication but is recommended to use [OpenID Connect](https://openid.net/connect/) as an extra authentication layer on top of OAuth (2.0).

    - Take in mind that his has an impact in latency due to the token decode and verification process.

### Pipeline

- Use Jenkins, Bamboo, or another automation server for the CICD pipeline.

- Create two Jobs, one for build and one for deployment:

    - The build job will be in charge of the following:

        - Download the API source code
        - Perform unit tests
        - Perform a static code scan using [Sonarqube](https://docs.sonarqube.org/latest/)
        - Perform a vulnerability scan using [Veracode](https://www.veracode.com)
        - Build the API Docker image and upload it to the Container Registry

    - The deployment job will be in charge of the following:

        - Deploy the necessary infrastructure in GCP using Terraform