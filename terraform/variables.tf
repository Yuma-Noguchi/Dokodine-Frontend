variable "project_id" {
  description = "The ID of the Google Cloud project"
  type = string
  default = "dokodine"
}

variable "region" {
  description = "The region to deploy the Cloud Run service"
  type = string
  default = "us-central1"
}

variable "service_name" {
  description = "The name of the Cloud Run service"
  type = string
}

variable "gar_repo" {
  description = "The ID of the Artifact Registry repository"
  type = string
}