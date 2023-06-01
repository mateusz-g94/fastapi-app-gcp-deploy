resource "google_cloud_run_service" "service" {
  name     = local.general.service_name
  location = local.general.location

  template {
    spec {
      containers {
        image = local.general.image_name
        ports {
          container_port = 5000
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  lifecycle {
    ignore_changes = [
      # metadata[0].annotations,
      # template[0].metadata[0].annotations,
      # template[0].metadata[0].name,
      # status[0].latest_created_revision_name,
      # status[0].latest_ready_revision_name,
      template[0].spec[0].containers[0].image
    ]
  }

}

resource "google_cloud_run_service_iam_member" "allUsers" {
  service  = google_cloud_run_service.service.name
  location = google_cloud_run_service.service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}