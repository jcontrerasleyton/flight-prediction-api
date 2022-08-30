output "run_service_url" {
  value = google_cloud_run_service.flight_prediction.status[0].url
}