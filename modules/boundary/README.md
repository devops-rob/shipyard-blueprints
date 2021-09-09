# Boundary blueprint for Shipyard

This blueprint will give you a containerised one node Boundary deployment in non-dev mode.

## Requirements

- Requires [shipyard](https://shipyard.run/) 0.3.29 or later

### Resources

- Boundary container
- Postgres container

### Example usage

#### Minimal example

```hcl
network "cloud" {
  subnet = "10.6.0.0/16"
}

module "boundary" {
    source = "github.com/devops-rob/shipyard-blueprints/modules//boundary"
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

variable "boundary_postgres_user" {
  default = "devopsrob"
}

variable "boundary_postgres_password" {
  default = "password"
}
module "boundary" {
    source = "github.com/devops-rob/shipyard-blueprints/modules//boundary"
}
```

### Optional inputs

| Variable | Default |
| -------- | ------- |
| network  | cloud   |
| boundary_postgres_version | latest |
| boundary_postgres_user | postgres |
| boundary_postgres_password | postgres |
| boundary_version | 0.5.0 |
