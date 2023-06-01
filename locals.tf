locals {
  general = merge(
    yamldecode(try(file("defaults/general.yaml"), "{}")),
    yamldecode(try(file("${terraform.workspace}/general.yaml"), "{}"))
  )
}