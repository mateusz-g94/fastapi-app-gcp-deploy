terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

# terraform {
#   backend "gcs" {
#     bucket  = "tf-state-prod"
#     prefix  = "terraform/state"
#   }
# }
