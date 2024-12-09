#!/bin/bash

# Variables
NAMESPACE="default"
DEPLOYMENT_NAME="nginx-deployment"
SERVICE_NAME="nginx-service"
INGRESS_NAME="nginx-ingress"
CONFIGMAP_NAME="nginx-html"
SECRET_NAME="nginx-tls-secret"

# Step 1: Delete Ingress
echo "Deleting Ingress resource..."
kubectl delete ingress ${INGRESS_NAME} --namespace ${NAMESPACE} --ignore-not-found

# Step 2: Delete Service
echo "Deleting Service..."
kubectl delete service ${SERVICE_NAME} --namespace ${NAMESPACE} --ignore-not-found

# Step 3: Delete Deployment
echo "Deleting Deployment..."
kubectl delete deployment ${DEPLOYMENT_NAME} --namespace ${NAMESPACE} --ignore-not-found

# Step 4: Delete ConfigMap
echo "Deleting ConfigMap..."
kubectl delete configmap ${CONFIGMAP_NAME} --namespace ${NAMESPACE} --ignore-not-found

# Step 5: Delete TLS Secret
echo "Deleting TLS Secret..."
kubectl delete secret ${SECRET_NAME} --namespace ${NAMESPACE} --ignore-not-found

# Verify Cleanup
echo "Verifying cleanup..."
kubectl get all --namespace ${NAMESPACE} | grep -E "${DEPLOYMENT_NAME}|${SERVICE_NAME}" || echo "No deployment or service resources found."
kubectl get ingress --namespace ${NAMESPACE} | grep "${INGRESS_NAME}" || echo "No ingress found."
kubectl get configmap --namespace ${NAMESPACE} | grep "${CONFIGMAP_NAME}" || echo "No configmap found."
kubectl get secret --namespace ${NAMESPACE} | grep "${SECRET_NAME}" || echo "No TLS secret found."

echo "Uninstallation complete!"

