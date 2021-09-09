variable "network" {
  default = "cloud"
}

container "vault" {
  image {
    name = "vault:${vault_version}"
  }

  command = [
    "vault",
    "server",
    "-dev",
    "-dev-root-token-id=${var.vault_token}",
    "-dev-listen-address=0.0.0.0:8200",
  ]

  port {
    local = 8200
    remote = 8200
    host = 8200
    open_in_browser = "/"
  }

  privileged = true

  # Wait for Vault to start
  health_check {
    timeout = "120s"
    http = "http://localhost:8200/v1/sys/health"
  }

  volume {
    source = "./config/vault/files"
    destination = "/files"
  }

  env {
    key = "VAULT_ADDR"
    value = "http://localhost:8200"
  }

  env {
    key = "VAULT_TOKEN"
    value = var.vault_token
  }

  network {
    name = "network.${var.network}"
  }
}
