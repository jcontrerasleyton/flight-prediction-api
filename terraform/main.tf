terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.53"
    }
  }
}

provider "google" {
  project = var.project
}

locals {
  service_folder = "api"
  service_name   = "flight-prediction"
  flight_prediction_worker_sa  = "serviceAccount:${google_service_account.flight_prediction_worker.email}"
}
