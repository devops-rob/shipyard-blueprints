# Vault blueprint for Shipyard

This blueprint will give you a containerised Vault server.

## Requirements

- Requires [shipyard](https://shipyard.run/) 0.3.29 or later

### Resources

- Vault container in dev mode

### Example usage

#### Minimal example

```hcl
network "cloud" {
  subnet = "10.6.0.0/16"
}

module "boundary" {
    source = "github.com/devops-rob/shipyard-blueprints/modules//vault-oss"
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

variable "vault_version" {
  default = "1.5.8"
}

variable "vault_token" {
  default = "devopsrob"
}

module "boundary" {
    source = "github.com/devops-rob/shipyard-blueprints/modules//vault-oss"
}
```

### Optional inputs

| Variable | Default |
| -------- | ------- |
| network  | cloud   |
| vault_version | 1.5.9 |
| vault_token | root |
