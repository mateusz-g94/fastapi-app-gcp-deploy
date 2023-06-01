resource "google_cloudbuild_trigger" "cloud_build_trigger" {

  github {
    owner = local.general.github_owner
    name  = local.general.github_repository
    push {
      branch = local.general.branch_name
    }
  }

  substitutions = {
    _LOCATION     = local.general.location
    _GCR_REGION   = local.general.gcr_region
    _SERVICE_NAME = local.general.service_name
  }

  filename = "cloudbuild.yaml"

}