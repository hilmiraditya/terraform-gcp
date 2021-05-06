data "google_client_config" "default" {}

provider "kubernetes" {
  load_config_file       = false
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_id
  name                       = var.name
  region                     = var.region
  zones                      = var.zones
  network                    = var.network
  subnetwork                 = var.subnetwork
  ip_range_pods              = var.ip_range_pods
  ip_range_services          = var.ip_range_services
  http_load_balancing        = var.http_load_balancing
  horizontal_pod_autoscaling = var.horizontal_pod_autoscaling
  network_policy             = var.network_policy

  node_pools = [
    {
      name               = "system"
      machine_type       = "e2-custom-2-3072"
      node_locations     = "asia-southeast1-a"
      min_count          = 1
      max_count          = 1
      local_ssd_count    = 0
      disk_size_gb       = 50
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = file("${path.module}/resources/service-account.json")
      preemptible        = true
      initial_node_count = 80
    },
  ]

  node_pools_labels = {
        all = {}
        system = {
            type = "system"
        }
    }

  node_pools_metadata = {
        all = {}
        system = {
            disable-legacy-endpoints = true
        }
    }

  node_pools_tags = {
        all = []
        system = [ "system" ]
  }
}