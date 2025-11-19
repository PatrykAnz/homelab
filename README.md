# Homelab Overview

Personal homelab setup running my home infrastructure.

## Stack
- CloudNativePG (PostgreSQL)
- Azure Key Vault
- External Secrets Operator
- Kustomize
- Tailscale (remote access)
- Azure Service Principal (authentication)

## Prereqs
- Kubernetes cluster (K3s)
- kubectl configured
- Azure Key Vault with secrets:
  - daylog-db-username
  - daylog-db-password
  - daylog-pgadmin-email
  - daylog-pgadmin-password
  - garmin-email
  - garmin-password
- Azure Service Principal stored as `azure-creds` in `external-secrets` namespace

## Notes:
- Secrets must exist in the right namespaces.
- Database password is synced from Azure Key Vault.
- CNPG creates its own internal secrets automatically.
- This is a personal environment, not production.