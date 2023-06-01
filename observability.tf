module "metrics_push" {
  source     = "./modules/observability"
  project_id = local.general.project
  region     = local.general.location
  scrape_jobs = {
    testing : {
      schedule : "* * * * *"
      endpoint : "${google_cloud_run_service.service.status[0].url}/metrics"
    }
  }
}

resource "google_monitoring_dashboard" "dashboard" {
  dashboard_json = file("./src/dashboard.json")
  lifecycle {
    ignore_changes = all
  }
}