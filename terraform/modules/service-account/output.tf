output "service_account_name" {
  value = "${google_service_account.developer-service-account.name}"
}

output "service_account_email" {
  value = "${google_service_account.developer-service-account.email}"
}

output "service_account_id" {
  value = "${google_service_account.developer-service-account.unique_id}"
}

