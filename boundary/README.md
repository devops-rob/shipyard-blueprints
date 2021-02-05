---
title: HashiCorp Boundary
author: DevOps Rob
slug: boundary
---

## Overview

This shipyard blueprint will provision HashiCorp Boundary in non-dev mode along with a postgres database.

To configure Boundary for the first time, you will need to use the recovery key to authenticate. More information about how to do this can be found here: https://boundaryproject.io/docs/installing/no-gen-resources#recovery-kms-workflow

## Usage 

```shell
shipyard run github.com/devops-rob/shipyard-blueprints//boundary

```
