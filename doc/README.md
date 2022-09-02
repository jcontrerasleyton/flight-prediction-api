# Cloud based flight delay prediction API

## Assumptions

These are the assumptions and decisions made for the design and development of this project:

- The model is assumed to be serialized and does not need to be retrained.
- The prediction is only made for one flight for each request to the api.
- Api users know the request format in advance.
- Selection of GCP over other cloud services is due to familiarity with the platform.
- Cloud Run is selected over Cloud Functions for the API deployment, taking into consideration that the former is capable of handling multiple requests at a time, while the latter only handles one request at a time.

---

## Model

The model, corresponding to a Logistic Regression model, predicts a categorical variable whose values ​​can be 1 (delay) or 0 (no delay). This model was selected after being compared to an XGBoost model and obtaining higher performance and much shorter processing time.

---

## Architecture

![Architecture diagram](/media/architecture.png)

The Continuos Integration and Continuous Delivery Pipeline for this project is the following:

First, Cloud Build is used to build and push a Python 3.7 based image to the GCP Container Registry, which wraps the Rest API and exposes it with a Gunicorn WSGI HTTP Server. 

Then, a Terraform manifest its aplied to enable the required APIs, create the Cloud Run service (sourcing the latest pushed image from Container Registry) and configure the IAM neened permissions throughout the automation.
