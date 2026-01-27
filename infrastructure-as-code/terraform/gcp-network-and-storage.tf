resource "google_storage_bucket" "ml_landing" {
  name     = "novaretail-ml-landing"
  location = var.gcp_region
}

resource "google_storage_bucket" "ml_features" {
  name     = "novaretail-ml-features"
  location = var.gcp_region
}
