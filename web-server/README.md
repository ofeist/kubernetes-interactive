# Kubernetes Nginx Deployment Repository

This repository contains configurations for deploying an **nginx** server in a Kubernetes cluster with support for both TLS-secured and non-TLS configurations. It is organized into two folders for clarity and flexibility:

## Folder Structure

- **`no-tls/`**:
  Contains YAML files for deploying nginx without TLS. This includes:
  - Deployment and Service configurations.
  - Ingress resource for plain HTTP traffic.
  - ConfigMap for custom content served by nginx.

- **`tls/`**:
  Contains YAML files for deploying nginx with TLS. This includes:
  - Deployment and Service configurations.
  - Ingress resource for HTTPS traffic.
  - TLS secrets and certificates for securing the connection.

## Prerequisites

- A functioning **Kubernetes cluster**.
- **kube-vip** configured to provide a virtual IP for the cluster.
- A properly installed and configured **Ingress Controller** (e.g., NGINX Ingress Controller).
- For the `tls/` setup:
  - Valid TLS certificates (self-signed or issued by a CA).
  - A Secret resource containing the certificate and key.

## Deployment Guide

### 1. Non-TLS Configuration
1. Navigate to the `no-tls/` folder:
   ```bash
   cd no-tls
   ```
2. Follow the instructions in the `README.md` within the `no-tls/` folder to deploy nginx.

### 2. TLS Configuration
1. Navigate to the `tls/` folder:
   ```bash
   cd tls
   ```
2. Follow the instructions in the `README.md` within the `tls/` folder to deploy nginx with TLS.

## Notes

- Ensure you update your `/etc/hosts` file to map the virtual IP to the appropriate hostnames.
- Monitor your Kubernetes cluster for any issues by checking pod logs and ingress events.
- If using `tls/`, ensure your certificates are valid and correctly referenced in the Secret resource.

