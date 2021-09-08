variable "db_host" {
  type = string
  default = "localhost"
}

variable "db_user" {
  type = string
  default = "boundary"
}

variable "db_password" {
  type = string
  default = "boundary"
}

variable "db_name" {
  type = string
  default = "boundary"
}

job "init" {
  datacenters = ["dc1"]

  group "boundary" {
    network {
      mode = "bridge"
    }

    service {
      name = "boundary"
      port = "9002"

      connect {
        sidecar_service {
          proxy {
            upstreams {
                destination_name = "cloudsql"
                local_bind_port = 5432
            }
          }
        }
      }
    }

    task "init" {
      driver = "docker"

      config {
        image   = "hashicorp/boundary:0.3.0"
        command = "boundary"
        args = [
            "database",
            "init",
            "-config=local/config.hcl"
        ]
        // entrypoint = ["tail"]
        // args = [
        //   "-f", "/dev/null"
        // ]
        // volumes = ["local/config.hcl:/boundary/config.hcl"]
      }

      resources {
        cpu    = 500
        memory = 256
      }

      env {
        // BOUNDARY_POSTGRES_URL = "postgresql://postgres:postgres@postgres.container.shipyard.run:5432/postgres?sslmode=disable"
        BOUNDARY_ADDR = "http://localhost:9200"
      }

            template {
        destination = "local/config.hcl"
        // env = {
        //   DB_HOST = var.db_host
        //   DB_USER = var.db_user
        //   DB_PASSWORD = var.db_password
        //   DB_NAME = var.db_name
        // }
        data = <<EOF
disable_mlock = true

controller {
  name = "demo-controller-1"
  description = "A controller for a demo!"

  database {
    url = "postgresql://boundary:boundary@localhost:5432/boundary?sslmode=disable"
  }
}
worker {
  name = "demo-worker-1"
  description = "A default worker created demonstration"
//   controllers = [
//     "120.0.0.1",
//   ]
  address = "127.0.0.1"
}

listener "tcp" {
  address = "0.0.0.0"
  purpose = "api"
  tls_disable = true 
}

listener "tcp" {
  address = "0.0.0.0"
  purpose = "cluster"
  tls_disable   = true 
}

listener "tcp" {
  address       = "0.0.0.0"
  purpose       = "proxy"
  tls_disable   = true 
}

kms "aead" {
  purpose = "root"
  aead_type = "aes-gcm"
  key = "uC8zAQ3sLJ9o0ZlH5lWIgxNZrNn0FiFqYj4802VKLKQ="
  key_id = "global_root"
}

kms "aead" {
  purpose = "worker-auth"
  aead_type = "aes-gcm"
  key = "cOQ9fiszFoxu/c20HbxRQ5E9dyDM6PqMY1GwqVLihsI="
  key_id = "global_worker-auth"
}

kms "aead" {
  purpose = "recovery"
  aead_type = "aes-gcm"
  key = "nIRSASgoP91KmaEcg/EAaM4iAkksyB+Lkes0gzrLIRM="
  key_id = "global_recovery"
}
EOF
      }
    }
  }
}
