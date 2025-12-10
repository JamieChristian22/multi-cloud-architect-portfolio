resource "google_bigquery_dataset" "customers_360" {
  dataset_id = "customers_360"
  location   = var.gcp_region
}

resource "google_bigquery_dataset" "fraud_features" {
  dataset_id = "fraud_features"
  location   = var.gcp_region
}

resource "google_bigquery_dataset" "recommendation_features" {
  dataset_id = "recommendation_features"
  location   = var.gcp_region
}
