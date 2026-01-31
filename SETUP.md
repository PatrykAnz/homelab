# Setup Guide

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

## Bootstrap

Install dependencies and bootstrap ArgoCD:

```bash
pip install -r requirements.txt
pre-commit install
kubectl apply -f bootstrap/application-homelab.yaml
```

## External Secrets (Azure Key Vault)

Remove `.example` from file and edit values:
platform/external-secrets/clustersecretstore-azure-key-vault.yaml.example -> platform/external-secrets/clustersecretstore-azure-key-vault.yaml

```bash
kubectl apply -f platform/external-secrets/clustersecretstore-azure-key-vault.yaml
```

## Terraform Setup

Remove .example from files and edit values:
terraform.tfvars.example -> terraform.tfvars
terraform.tf.example -> terraform.tf

Run:

```bash
cd infra/terraform
terraform init
terraform plan
terraform apply
```

## CI/CD Setup

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

## Home Automation Setup

Remove .example from file and edit values:
.env.example -> .env

Create Mosquitto password file:

```bash
cd host-services/home-automation
source .env
docker run --rm -v "$(pwd):/out" eclipse-mosquitto:2 \
  sh -c "mosquitto_passwd -c -b /out/passwd '$MQTT_USER' '$MQTT_PASSWORD'"
```

Start stack:

```bash
docker compose up -d
```
