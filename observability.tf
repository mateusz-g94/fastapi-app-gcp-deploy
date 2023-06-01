module "metrics_push" {
  source     = "./modules/observability"
  project_id = local.general.project
  region = local.general.location
  scrape_jobs = {
    testing : {
      schedule : "* * * * *"
      endpoint : "${google_cloud_run_service.service.status[0].url}/metrics" 
    }
  }
}