# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }

terraform {
  backend "gcs" {
    bucket = "tfstate-01062023"
    prefix = "terraform/state"
  }
}
