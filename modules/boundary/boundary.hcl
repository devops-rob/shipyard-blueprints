template "create_boundary_config" {
  source = file("./config/boundary/files/config.hcl")
  destination = "${data("boundary")}/config.hcl"
}

template "create_boundary_recovery" {
  source = file("./config/boundary/files/recovery.hcl")
  destination = "${data("boundary")}/recovery.hcl"
}

exec_remote "boundary-init" {
    image  {
        name = "hashicorp/boundary:${var.boundary_version}"
    }

    cmd = "boundary"
    args = [
        "database",
        "init",
        "-skip-target-creation",
        "-skip-scopes-creation",
        "-skip-host-resources-creation",
        "-skip-auth-method-creation",
        "-config=/boundary/config.hcl"
    ]


    env {
        key = "BOUNDARY_POSTGRES_URL"
        value = "postgresql://${var.boundary_postgres_user}:${var.boundary_postgres_password}@postgres.container.shipyard.run:5432/postgres?sslmode=disable"
    }

    network {
        name = "network.${var.network}"
    }

    volume {
    source = data("boundary")
    destination = "/boundary"
  }

    depends_on = [
        "container.postgres",
        "exec_remote.psql_checker"
    ]

}

container "boundary" {
    image  {
        name = "hashicorp/boundary:${var.boundary_version}"
    }

    command = [
        "boundary",
        "server",
        "-config=/boundary/config.hcl"
    ]

    port {
        local = 9200
        remote = 9200
        host = 9200
    }

        port {
        local = 9201
        remote = 9201
        host = 9201
    }

        port {
        local = 9202
        remote = 9202
        host = 9202
    }

    privileged = true

    env {
        key   = "BOUNDARY_POSTGRES_URL"
        value = "postgresql://${var.boundary_postgres_user}:${var.boundary_postgres_password}@postgres.container.shipyard.run:5432/postgres?sslmode=disable"
    }

    env {
        key   = "BOUNDARY_ADDR"
        value = "http://localhost:9200"
    }

    network {
        name = "network.${var.network}"
    }

    volume {
    source = data("boundary")
    destination = "/boundary"
  }
    depends_on = [
        "exec_remote.boundary-init",
        "exec_remote.psql_checker"
    ]
}
