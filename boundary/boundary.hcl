exec_remote "boundary-init" {
    image  {
        name = "hashicorp/boundary:0.5.0"
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

    // privileged = true

    env {
        key = "BOUNDARY_POSTGRES_URL"
        value = "postgresql://postgres:postgres@postgres.container.shipyard.run:5432/postgres?sslmode=disable"
    }

    network {
        name = "network.public"
        ip_address = "10.16.0.200"
    }

    volume {
        source = "./config/boundary/files"
        destination = "/boundary"
    }

    depends_on = [
        "container.postgres",
        "exec_remote.psql_checker"
    ]

}

container "boundary" {
    image  {
        name = "hashicorp/boundary:0.5.0"
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
        open_in_browser = "/"
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
        value = "postgresql://postgres:postgres@postgres.container.shipyard.run:5432/postgres?sslmode=disable"
    }

    env {
        key   = "BOUNDARY_ADDR"
        value = "http://localhost:9200"
    }

    network {
        name = "network.public"
        ip_address = "10.16.0.201"
    }

    volume {
        source = "./config/boundary/files"
        destination = "/boundary"
    }

    depends_on = [
        "exec_remote.boundary-init",
        "exec_remote.psql_checker"
    ]
}
