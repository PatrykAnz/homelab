# Homelab

Personal Kubernetes homelab running on K3s.

## Tech Stack

- **Orchestration**: Kubernetes (K3s)
- **GitOps**: ArgoCD
- **CI/CD**: GitHub Actions with OIDC
- **Infrastructure as Code**: Terraform
- **Database**: PostgreSQL 18 (CloudNativePG, 3-node HA)
- **Database Admin**: pgAdmin 4
- **Secrets**: Azure Key Vault + External Secrets Operator
- **Networking**: Tailscale
- **Config Management**: Kustomize
- **Code Quality**: pre-commit (kubeconform, prettier, terraform fmt, tflint)
- **Application Runtime**: Python 3.12, FastAPI/uvicorn

## Table of Contents

- [Prerequisites](#prerequisites)
- [Azure Key Vault Secrets](#azure-key-vault-secrets)
- [Setup](#setup)
- [Infrastructure](#infrastructure)
- [CI/CD](#cicd)
- [Services](#services)
- [Ports](#ports)

## Prerequisites

- K3s cluster with kubectl configured
- Tailscale for remote access
- Azure subscription with:
  - Resource Group
  - Key Vault
  - Storage Account (for Terraform state)
  - User Assigned Identity (for GitHub OIDC)
- GitHub repository secrets configured (see [CI/CD Setup](#cicd-setup))
- Azure Key Vault secrets configured (see [Azure Key Vault Secrets](#azure-key-vault-secrets))

## Azure Key Vault Secrets

Required secrets in Azure Key Vault:

| Secret                    | Description                  |
| ------------------------- | ---------------------------- |
| `daylog-db-username`      | PostgreSQL database username |
| `daylog-db-password`      | PostgreSQL database password |
| `daylog-pgadmin-email`    | pgAdmin login email          |
| `daylog-pgadmin-password` | pgAdmin login password       |
| `garmin-email`            | Garmin Connect email         |
| `garmin-password`         | Garmin Connect password      |
| `withings-client-id`      | Withings API client ID       |
| `withings-client-secret`  | Withings API client secret   |

## Setup

```bash
# Install dependencies
pip install -r requirements.txt
pre-commit install

# Bootstrap ArgoCD (one-time)
kubectl apply -f argocd/application-homelab.yaml
```

ArgoCD will sync everything else automatically.

## Infrastructure

Terraform modules for Azure infrastructure:

| Module                                | Description                         |
| ------------------------------------- | ----------------------------------- |
| `azure_key_vault`                     | Azure Key Vault for secrets         |
| `azure_storage_account`               | Storage account for Terraform state |
| `azure_user_assigned_identity`        | Managed identity for OIDC           |
| `azure_federated_identity_credential` | GitHub OIDC federation              |
| `azure_role_assignment`               | RBAC role assignments               |

### Terraform Setup

```bash
cd infra/terraform

# Copy example files
cp terraform.tfvars.example terraform.tfvars
cp terraform.tf.example terraform.tf

# Edit terraform.tfvars with your values
# Then initialize and apply
terraform init
terraform plan
terraform apply
```

## CI/CD

GitHub Actions workflows with Azure OIDC authentication (no stored secrets):

| Workflow               | Trigger                | Description                    |
| ---------------------- | ---------------------- | ------------------------------ |
| `deploy-infra.yaml`    | PR / Push to main      | Main orchestrator              |
| `terraform-plan.yaml`  | Called by deploy-infra | Run terraform plan, post to PR |
| `terraform-apply.yaml` | Called by deploy-infra | Apply changes after merge      |

### CI/CD Flow

1. **PR opened** → Plan runs, posts diff as PR comment
2. **PR merged** → Apply runs automatically (if changes exist)
3. **No changes** → Apply skipped

### CI/CD Setup

Configure these GitHub repository secrets:

| Secret                           | Description                        |
| -------------------------------- | ---------------------------------- |
| `AZURE_CLIENT_ID`                | User Assigned Identity Client ID   |
| `AZURE_TENANT_ID`                | Azure Tenant ID                    |
| `AZURE_SUBSCRIPTION_ID`          | Azure Subscription ID              |
| `AZURE_RESOURCE_GROUP`           | Resource Group name                |
| `AZURE_STORAGE_ACCOUNT`          | Storage Account name               |
| `AZURE_TFSTATE_CONTAINER`        | Blob container for tfstate         |
| `AZURE_KEY_VAULT_NAME`           | Key Vault name                     |
| `TF_LOCATION`                    | Azure region (e.g., `northeurope`) |
| `TF_USER_ASSIGNED_IDENTITY_NAME` | Identity name                      |
| `TF_GITHUB_ORG`                  | GitHub organization/user           |
| `TF_GITHUB_REPO`                 | Repository name                    |
| `TF_ENVIRONMENT`                 | Environment name (e.g., `dev`)     |

## Services

### DayLog Sync Jobs

Container: `ghcr.io/patrykanz/daylog:latest`

- **Garmin Sync** — Daily at 2:00 AM
- **Withings Sync** — Daily at 2:00 AM

Manual jobs available for full year syncs:

- `kubectl apply -f apps/daylog/job-garmin-sync-annual.yaml`
- `kubectl apply -f apps/daylog/job-withings-sync-annual.yaml`

### Database

PostgreSQL 18 via CloudNativePG (3 replicas, 1Gi storage)

## Ports

All services accessible via `<tailscale-ip>`:

| Service    | Port    | URL                            |
| ---------- | ------- | ------------------------------ |
| ArgoCD     | `30443` | `https://<tailscale-ip>:30443` |
| pgAdmin    | `30091` | `http://<tailscale-ip>:30091`  |
| PostgreSQL | `5432`  | `<tailscale-ip>:5432`          |

### Temporary

- **Withings OAuth** (`8081`) — Only when running `SYNC_MODE=server` for initial OAuth setup
