# Postgres blueprint for Shipyard

This blueprint will give you a containerised Postgres database.

## Requirements

- Requires [shipyard](https://shipyard.run/) 0.3.29 or later

### Resources

- Postgres container

### Example usage

#### Minimal example

```hcl
network "cloud" {
  subnet = "10.6.0.0/16"
}

module "postgres" {
    source = "github.com/devops-rob/shipyard-blueprints/modules//postgres"
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

variable "postgres_user" {
  default = "devopsrob"
}

variable "postgres_password" {
  default = "password"
}

module "postgres" {
    source = "github.com/devops-rob/shipyard-blueprints/modules//postgres"
}
```

### Optional inputs

| Variable | Default |
| -------- | ------- |
| network  | cloud   |
| postgres_version | latest |
| postgres_user | postgres |
| postgres_password | postgres |
