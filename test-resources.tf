resource "google_compute_image" "example" {
  name = "example-image"

  raw_disk {
    source = "https://storage.googleapis.com/bosh-gce-raw-stemcells/bosh-stemcell-97.98-google-kvm-ubuntu-xenial-go_agent-raw-1557960142.tar.gz"
  }
  labels = {
    "BU:ID"    = "13578"
    CostCentre = "PAL-1001-2378"
    Owner      = "ssdl-gcp@deloitte.com"
    Project    = "SSDL_CloudSecurity"
  }
}
resource "google_bigquery_dataset_iam_member" "editor" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = "allUsers"
}
resource "google_service_account" "myaccount" {
  account_id   = "myaccount"
  display_name = "My Service Account GCP"
}

resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.myaccount.name1
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "example_dataset"
  labels = {
    "BU:ID"    = "13578"
    CostCentre = "PAL-1001-2378"
    Owner      = "ssdl-gcp@deloitte.com"
    Project    = "SSDL_CloudSecurity"
  }
}
resource "google_compute_instance_from_machine_image" "tpl" {
  provider = google-beta
  name     = "instance-from-machine-image"
  zone     = "us-central1-a"

  source_machine_image = "projects/PROJECT-ID/global/machineImages/trusted-gcp-image"

  // Override fields from machine image
  can_ip_forward = false
  labels = {
    my_key = "my_value"
  }
}
resource "google_compute_subnetwork" "subnetwork-ipv6" {
  name = "ipv6-test-subnetwork"

  ip_cidr_range = "10.0.0.0/22"
  region        = "us-west2"

  stack_type       = "IPV4_IPV6"
  ipv6_access_type = "EXTERNAL"

  network = google_compute_network.custom-test.id
}

resource "google_compute_network" "custom-test" {
  name                    = "ipv6-test-network"
  auto_create_subnetworks = false
}
resource "google_compute_network_peering" "peering1" {
  name         = "peering1"
  network      = google_compute_network.default.self_link
  peer_network = google_compute_network.other.self_link
}
resource "google_sql_database_instance" "instance" {
  provider = google-beta

  name             = "private-instance-${random_id.db_name_suffix.hex}"
  region           = "us-central1"
  database_version = "MYSQL_5_7"

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled                                  = true
      private_network                               = google_compute_network.private_network.id
      enable_private_path_for_google_cloud_services = true
    }
  }
}
provider "google-beta" {
  region = "us-central1"
  zone   = "us-central1-a"
}
