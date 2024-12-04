output "service_url" {
  value = google_cloud_run_v2_service.dokodine-frontend.uri
}

output "github_actions_key" {
  value     = google_service_account_key.github_actions_key.private_key
  sensitive = true
}