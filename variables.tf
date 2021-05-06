variable "project_id" {
    type = string
    default = "xuryaeligibility"
}

variable "name" {
    type = string
    default = "xurya-production-test"
}

variable "network" {
    type = string
    default = "default"
}

variable "subnetwork" {
    type = string
    default = "default"
}

variable "ip_range_pods" {
    type = string
    default = "gke-xurya-production-pods-5b7f6023"
}

variable "ip_range_services" {
    type = string
    default = "gke-xurya-production-services-5b7f6023"
}

variable "region" {
    type = string
    default = "asia-southeast1"
}

variable "zones" {
    type = list(string)
    default = ["asia-southeast1-a"]
}

variable "network_policy" {
    type = bool
    default = false
}

variable "horizontal_pod_autoscaling" {
    type = bool
    default = false
}

variable "http_load_balancing" {
    type = bool
    default = true
}

# variable "node_pools" {
#     type = list(map(string))
#     description = "List of maps containing node pools"
#     default = [
#     {
#       name               = "system"
#       machine_type       = "e2-custom-2-3072"
#       node_locations     = "asia-southeast1-a"
#       min_count          = 1
#       max_count          = 1
#       local_ssd_count    = 0
#       disk_size_gb       = 50
#       disk_type          = "pd-standard"
#       image_type         = "COS"
#       auto_repair        = true
#       auto_upgrade       = true
#       service_account    = file("${path.module}/resources/service-account.json")
#       preemptible        = true
#       initial_node_count = 80
#     },
#   ]
# }

variable "node_pools_labels" {
    type = map(map(string))
    description = "Map of maps containing node labels by node-pool name"
    default = {
        all = {}
        system = {
            type = "system"
        }
    }
}

variable "node_pools_tags" {
    type = map(list(string))	
    description = "Map of lists containing node network tags by node-pool name	"
    default = {
        all = []
        system = [ "system" ]
  }
}

variable "node_pools_metadata" {
    type = map(map(string))
    description = "Map of maps containing node metadata by node-pool name"
    default = {
        all = {}
        system = {
            disable-legacy-endpoints = true
        }
    }
}