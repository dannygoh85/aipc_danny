terraform {
  required_version = "1.2.2"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.21.0"
    }
    hashicorp = {
        source = "hashicorp/local"
        version = "2.2.3"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = "2.17.0"
    }
  }
}

provider digitalocean {
  # Configuration options
  token = var.DO_token
}

provider "docker" {
  # Configuration options
  host = "unix:///var/run/docker.sock"
}