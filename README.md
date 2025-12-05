# Homelab

Personal Kubernetes homelab running on K3s.

## Tech Stack

- **Orchestration**: Kubernetes (K3s)
- **GitOps**: ArgoCD
- **Database**: PostgreSQL 18 (CloudNativePG, 3-node HA)
- **Secrets**: Azure Key Vault + External Secrets Operator
- **Networking**: Tailscale
- **Config Management**: Kustomize

## Prerequisites

- K3s cluster with kubectl configured
- Tailscale for remote access
- Azure Key Vault with these secrets:
  - `daylog-db-username`
  - `daylog-db-password`
  - `daylog-pgadmin-email`
  - `daylog-pgadmin-password`
  - `garmin-email`
  - `garmin-password`
  - `withings-client-id`
  - `withings-client-secret`
- `azure-creds` secret in `external-secrets` namespace (Service Principal)
- `azure-config` secret in `daylog` namespace with `key-vault-name` and `tenant-id`

## Setup

```bash
# Install
pip install -r requirements.txt
pre-commit install

# Bootstrap ArgoCD (one-time)
kubectl apply -f argocd/application-homelab.yaml
```

ArgoCD will sync everything else automatically.

## What's Running

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
