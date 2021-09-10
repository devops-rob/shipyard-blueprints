container "memcached" {
    image {
        name = "memcached:${var.memcached_version}"
    }

    port {
        local  = 11211
        host   = 11211
        remote = 11211
    }

    network {
        name = "network.${var.network}"
    }

    resources {
        memory = var.memcached_memory_limit
    }
}
