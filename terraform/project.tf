# Enable services
resource "google_project_service" "run" {
  service = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "iam" {
  service = "iam.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudbuild" {
  service = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}

# Create a service account
resource "google_service_account" "flight_prediction_worker" {
  account_id   = "flight-prediction-worker"
  display_name = "Flight Prediction worker SA"
}

# Set permissions
resource "google_project_iam_binding" "service_permissions" {
  role       = "roles/run.invoker"
  members    = [local.flight_prediction_worker_sa]
  depends_on = [google_service_account.flight_prediction_worker]
}
