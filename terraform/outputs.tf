output "service_url" {
  value = google_cloud_run_service.dokodine-backend.status[0].url
}

output "github_actions_key" {
  value     = google_service_account_key.github_actions_key.private_key
  sensitive = true
}