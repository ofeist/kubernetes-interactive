#!/bin/bash

# Step 1: Generate TLS Certificate and Create Secret
echo "Generating TLS certificate and creating Kubernetes secret..."
./generate-tls.sh

# Step 2: Apply ConfigMap
echo "Applying ConfigMap..."
kubectl apply -f nginx-configmap.yaml

# Step 3: Deploy Nginx Deployment and Service
echo "Applying Nginx Deployment and Service..."
kubectl apply -f nginx-deployment.yaml

# Step 4: Apply Ingress
echo "Applying Ingress resource..."
kubectl apply -f nginx-ingress.yaml

# Step 5: Verify Deployment
echo "Verifying resources..."
kubectl get pods
kubectl get svc
kubectl get ingress

echo "Deployment complete!"

