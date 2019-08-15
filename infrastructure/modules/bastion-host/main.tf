provider "google" {
  version     = "~> 2.12"
  project     = "${var.project_id}"
  region      = "${var.region}"
  credentials = "${file(var.credentials)}"
}

provider "google-beta" {
  version     = "~> 2.12"
  project     = "${var.project_id}"
  region      = "${var.region}"
  credentials = "${file(var.credentials)}"
}

resource "google_service_account" "developer-service-account" {
  account_id   = "${var.developer_service_account_name}"
  display_name = "${var.developer_service_account_name}"
}

resource "google_project_iam_member" "compute-instance-admin" {
  project = "${var.project_id}"
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${google_service_account.developer-service-account.email}"
}


resource "google_project_iam_member" "compute-container-developer" {
  project = "${var.project_id}"
  role    = "roles/container.developer"
  member  = "serviceAccount:${google_service_account.developer-service-account.email}"
}

resource "google_project_iam_member" "iam-service-account-user" {
  project = "${var.project_id}"
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.developer-service-account.email}"
}

resource "google_compute_instance" "bastion-host" {
  name         = "${var.bastion_host_name}"
  machine_type = "n1-standard-1"
  zone         = "${var.zone}"

  tags = ["ssh", "bastion-host"]

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  network_interface {
    subnetwork = "${var.bastion_host_subnet_name}"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    email  = "${google_service_account.developer-service-account.email}"
    scopes = ["cloud-platform"]
  }

  depends_on = ["google_project_iam_member.compute-container-developer", "google_project_iam_member.compute-instance-admin"]

  provisioner "remote-exec" {
    connection {
      host        = "${google_compute_instance.bastion-host.network_interface.0.access_config.0.nat_ip}"
      user        = "${var.ssh_user}"
      type        = "ssh"
      private_key = "${file(var.ssh_key)}"
    }

    inline = [
      "sudo yum install -y kubectl",
      "gcloud config set compute/zone ${var.zone}",
      "gcloud container clusters get-credentials ${var.gke_cluster_name}"
    ]
  }
}
