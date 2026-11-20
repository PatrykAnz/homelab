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

| Secret                   | Description            |
| ------------------------ | ---------------------- |
| `grafana-admin-user`     | Grafana admin username |
| `grafana-admin-password` | Grafana admin password |

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

The store authenticates with the Kubernetes Secret `external-secrets/azure-creds`. ESO cannot
fetch this from Key Vault (it is the key to Key Vault), so it is created by hand. Recreate it the
same way on a fresh cluster or restore, and after every password rotation:

```bash
KV=<key-vault-name>
kubectl -n external-secrets create secret generic azure-creds \
  --from-literal=ClientID="$(az keyvault secret show --vault-name "$KV" -n azure-client-id --query value -o tsv)" \
  --from-literal=ClientSecret="$(az keyvault secret show --vault-name "$KV" -n azure-client-secret --query value -o tsv)" \
  --dry-run=client -o yaml | kubectl apply -f -
kubectl get clustersecretstore azure-key-vault-store   # STATUS must be Valid / READY True
```

### Password rotation

- Terraform rotates the ESO password only when an apply runs after
  `terraform output external_secrets_password_rotation_due`. The old password is revoked in that
  same apply, so update `azure-creds` (above) immediately after it.
- `terraform output external_secrets_password_expires` is the hard deadline. Put a calendar
  reminder a month before `rotation_due` and run plan/apply then, not on the expiry day.

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

The public workflow reports only whether the plan has changes. It does not publish plan output or
upload plan artifacts; apply creates a fresh plan after environment approval. For diagnostics, run
Terraform locally with the required credentials.

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
