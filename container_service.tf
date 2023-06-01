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
      container_concurrency = 0
    }
  }

  metadata {
    annotations = {
      "autoscaling.knative.dev/maxScale" = 1500
      "autoscaling.knative.dev/minScale" = 0
      "run.googleapis.com/ingress" = "all"
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  lifecycle {
    ignore_changes = [
      template[0].spec[0].containers[0].image,
      template[0].spec[0].container_concurrency
    ]
  }
}

resource "google_service_account" "service_account_apigw" {
  account_id = google_api_gateway_api.api_gw.api_id
}

resource "google_cloud_run_service_iam_member" "apigw_access" {
  service  = google_cloud_run_service.service.name
  location = google_cloud_run_service.service.location
  project  = google_cloud_run_service.service.project
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.service_account_apigw.email}"
}

resource "google_cloud_run_service_iam_member" "function_access" {
  service  = google_cloud_run_service.service.name
  location = google_cloud_run_service.service.location
  project  = google_cloud_run_service.service.project
  role     = "roles/run.invoker"
  member   = "serviceAccount:${module.metrics_push.sa}"
}
