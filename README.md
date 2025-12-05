# Homelab Overview

Personal homelab setup running my home infrastructure.

## Stack

- ArgoCD
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
  - withings-client-id
  - withings-client-secret
- Azure Service Principal stored as `azure-creds` in `external-secrets` namespace

## Ports

### Always Available

Services exposed using NodePort:

- **ArgoCD HTTP** (`30080`/HTTP)
  - GitOps UI
  - Access: `http://<tailscale-ip>:30080`

- **ArgoCD HTTPS** (`30443`/HTTPS)
  - GitOps UI (recommended)
  - Access: `https://<tailscale-ip>:30443`

- **pgAdmin** (`30091`/HTTP)
  - PostgreSQL administration interface
  - Access: `http://<tailscale-ip>:30091`

- **PostgreSQL** (`5432`/TCP)
  - Database connection
  - Access: `<tailscale-ip>:5432`

### Conditional Services

Ports used by temporary jobs or manually started services:

- **Withings OAuth Server** (`8081`/HTTP)
  - FastAPI/uvicorn server for OAuth callback flow
  - **Availability**: Only active when running with `SYNC_MODE=server` or manually started for initial OAuth setup
  - Callback endpoint: `http://localhost:8081/callback`

## Notes:

- Secrets must exist in the right namespaces.
- Database password is synced from Azure Key Vault.
- CNPG creates its own internal secrets automatically.
- This is a personal environment, not production.
