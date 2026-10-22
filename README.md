# Homelab

Personal Kubernetes homelab running on K3s with GitOps.

## Stack

**Kubernetes:** K3s

**GitOps:** ArgoCD

**IaC:** Terraform (Azure)

**Delivery:** PR-driven workflows with OIDC

**Secrets:** Azure Key Vault + External Secrets Operator

**Networking:** Tailscale

**Home Automation:** Mosquitto, Zigbee2MQTT, Home Assistant (Docker on host)

See [SETUP.md](SETUP.md) for prerequisites and bootstrap instructions.

## Infrastructure

Terraform modules: Key Vault, storage (tfstate), user-assigned identity (OIDC), federated credentials, RBAC.

## Delivery

PR-driven Terraform workflows via GitHub Actions with OIDC (no stored credentials). Plan on PR, apply on merge.

## Services

**Home Automation:** Mosquitto (MQTT), Zigbee2MQTT, Home Assistant (Docker on host)

## Access

All services via Tailscale:

| Service        | Port    |
| -------------- | ------- |
| ArgoCD         | `30443` |
| MQTT           | `1884`  |
| Zigbee2MQTT    | `8080`  |
| Home Assistant | `8123`  |
