terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
  backend "remote" {
    organization = "dokodine"
    workspaces {
      prefix = "frontend-"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_artifact_registry_repository" "dokodine-frontend-repo" {
  location      = var.region
  repository_id = var.gar_repo
  description   = "Docker repository for Next.js app"
  format        = "DOCKER"
}

resource "google_cloud_run_v2_service" "dokodine-frontend" {
  name     = var.service_name
  location = var.region

  template {
    containers {
      image = "gcr.io/cloudrun/hello" # Placeholder image
    }
  }
}

resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_v2_service.dokodine-frontend.name
  location = google_cloud_run_v2_service.dokodine-frontend.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_service_account" "github_actions" {
  account_id   = "github-actions-${terraform.workspace}"
  display_name = "Service Account for GitHub Actions (${terraform.workspace})"
}

resource "google_project_iam_member" "artifact_registry_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_project_iam_member" "cloud_run_developer" {
  project = var.project_id
  role    = "roles/run.developer"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_service_account_key" "github_actions_key" {
  service_account_id = google_service_account.github_actions.name
}