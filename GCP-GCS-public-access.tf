resource "google_storage_bucket_iam_member" "member" {
  bucket = "test-bucket-highmark"
  role = "roles/storage.admin"
  member = "allAuthenticatedUsers"

  condition {
    title       = "expires_after_2019_12_31"
    description = "Expiring at midnight of 2019-12-31"
    expression  = "request.time < timestamp(\"2020-01-01T00:00:00Z\")"
  }
}