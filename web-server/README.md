# Nginx Deployment with Ingress

This guide explains the deployment of an **nginx** server in a Kubernetes cluster with access via an **Ingress** resource at the path `/web` on the host `baba.local`. It also includes steps for using a ConfigMap to customize the content served by nginx.

## Prerequisites
- A functioning **Kubernetes cluster**.
- **kube-vip** configured to provide a virtual IP for your cluster.
- A properly installed and configured **Ingress Controller** (e.g., NGINX Ingress Controller).

## Overview
- **Deployment**: An nginx server is deployed with one replica.
- **Service**: A ClusterIP service exposes the nginx deployment internally.
- **ConfigMap**: Provides the content to be served by nginx.
- **Ingress**: Configured to route HTTP traffic for `http://baba.local/web` to the nginx service.
- **IngressClass**: Ensures the Ingress resource is associated with the correct Ingress Controller.

---

## Files Included

### 1. `nginx-deployment.yaml`
Defines the nginx deployment and service, with a volume mount to include content from a ConfigMap.

### 2. `nginx-configmap.yaml`
Contains the HTML content to be served by nginx.

### 3. `nginx-ingress.yaml`
Configures the Ingress resource to expose the nginx service at `http://baba.local/web`.

---

## Deployment Steps

1. **Create ConfigMap**:
   Define a ConfigMap with the content to be served by nginx. For example:
   ```bash
   kubectl apply -f nginx-configmap.yaml
   ```

2. **Apply Deployment and Service**:
   Deploy nginx with a volume mount that uses the ConfigMap for serving content.
   ```bash
   kubectl apply -f nginx-deployment.yaml
   ```

3. **Verify Deployment and Service**:
   Check that the nginx pods and service are running:
   ```bash
   kubectl get pods
   kubectl get svc
   ```

4. **Apply Ingress Resource**:
   Create the Ingress resource to expose nginx via the `/web` path on the host `baba.local`:
   ```bash
   kubectl apply -f nginx-ingress.yaml
   ```

5. **Verify Ingress**:
   Ensure the Ingress resource is correctly applied:
   ```bash
   kubectl get ingress
   ```

6. **Update Local `/etc/hosts`**:
   Add the following line to your `/etc/hosts` file:
   ```
   <kube-vip-ip>  baba.local
   ```
   Replace `<kube-vip-ip>` with your kube-vip virtual IP address.

7. **Test Access**:
   Open a browser or use `curl` to test:
   ```bash
   curl http://baba.local/web
   ```

---

## Notes
- Ensure your Kubernetes cluster has a properly configured **Ingress Controller** (e.g., NGINX Ingress Controller).
- Verify that the ConfigMap is correctly mounted in the nginx pod and serving the intended content.
- Check logs of the Ingress Controller for debugging if necessary:
  ```bash
  kubectl logs <ingress-controller-pod> -n ingress-nginx
  ```
- The Ingress resource uses the `nginx` IngressClass. Modify `ingressClassName` if your environment uses a different class.

For further customization or troubleshooting, feel free to modify the included YAML files!


