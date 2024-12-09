# TLS-Enabled Nginx Deployment

This guide explains how to deploy an **nginx** server in a Kubernetes cluster with TLS support using self-signed certificates. The deployment includes a custom HTML page served via HTTPS and accessible at `https://baba.local/web`.

## Prerequisites
- A functioning **Kubernetes cluster**.
- **kube-vip** configured to provide a virtual IP for the cluster.
- A properly installed and configured **Ingress Controller** (e.g., NGINX Ingress Controller).
- Access to the following YAML files:
  - `generate-tls.sh`
  - `nginx-configmap.yaml`
  - `nginx-deployment.yaml`
  - `nginx-service.yaml`
  - `nginx-ingress.yaml`

---

## Deployment Steps

### 1. Generate TLS Certificates
Run the `generate-tls.sh` script to create a self-signed certificate and a Kubernetes TLS secret:
```bash
./generate-tls.sh
```
This script generates a self-signed certificate (`tls.crt`) and a private key (`tls.key`) and creates a Kubernetes TLS secret named `nginx-tls-secret`.

### 2. Apply ConfigMap
Create the ConfigMap for the custom HTML page:
```bash
kubectl apply -f nginx-configmap.yaml
```

### 3. Deploy Nginx
Deploy the nginx server and its service:
```bash
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml
```

### 4. Apply Ingress Resource
Create the Ingress resource for TLS termination and route traffic to nginx:
```bash
kubectl apply -f nginx-ingress.yaml
```
**Note**: The TLS termination occurs at the Ingress Controller, which handles SSL decryption and forwards plain HTTP traffic to the nginx service.

### 5. Verify Deployment
Check the status of pods, services, and ingress:
```bash
kubectl get pods
kubectl get svc
kubectl get ingress
```
Ensure all resources are running and correctly configured.

### 6. Update Local `/etc/hosts`
Add the following line to your `/etc/hosts` file to map the virtual IP to the hostname:
```bash
<kube-vip-ip>  baba.local
```
Replace `<kube-vip-ip>` with the IP address configured via kube-vip.

### 7. Test the Setup
Access the nginx server in your browser or via `curl`:
```bash
curl -k https://baba.local/web
```
You should see the custom HTML page with the message **"SSL-Ekola!"**.

---

## Notes
- If any issues arise, check the logs of the Ingress Controller for debugging:
  ```bash
  kubectl logs <ingress-controller-pod-name> -n ingress-nginx
  ```
- The `nginx-tls-secret` must be present in the same namespace as the ingress resource.
- Ensure the Ingress Controller is correctly configured to handle TLS traffic.

For troubleshooting or further customization, feel free to modify the provided YAML files.


