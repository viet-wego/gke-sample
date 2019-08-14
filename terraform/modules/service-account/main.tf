resource "google_service_account" "developer-service-account" {
  account_id = "${var.developer_service_account_name}"
}

resource "google_project_iam_member" "compute-instance-admin" {
  project = "${var.project_id}"
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${google_service_account.developer-service-account.email}"
}


resource "google_project_iam_member" "compute-contianer-developer" {
  project = "${var.project_id}"
  role    = "roles/container.developer"
  member  = "serviceAccount:${google_service_account.developer-service-account.email}"
}

