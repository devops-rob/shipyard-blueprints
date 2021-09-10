# Memcached blueprint for Shipyard

This blueprint will give you a containerised memcached server.

## Requirements

- Requires [shipyard](https://shipyard.run/) 0.3.29 or later

### Resources

- memcached container

### Example usage

#### Minimal example

```hcl
network "cloud" {
  subnet = "10.6.0.0/16"
}

module "memcached" {
    source = "github.com/devops-rob/shipyard-blueprints/modules//memcached"
}
```

#### Variable example

```hcl
network "test" {
  subnet = "10.6.0.0/16"
}

variable "network" {
  default = "test"
}

variable "memcached_version" {
  default = "1.6.9"
}

variable "memcached_memory_limit" {
  default = "100"
}

module "memcached" {
    source = "github.com/devops-rob/shipyard-blueprints/modules//memcached"
}
```

### Optional inputs

| Variable | Default |
| -------- | ------- |
| network  | cloud   |
| memcached_version | 1.6.10 |
| memcached_memory_limit | 64 |
