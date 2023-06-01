provider "google" {
  credentials = file("mlops-sandbox-30052023-e020-7c13599ce519.json")
  project     = local.general.project
  region      = local.general.location
}

terraform {
  required_version = ">= 1.4"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
}