#!/bin/bash

# Variables
NAMESPACE="default"
SECRET_NAME="nginx-tls-secret"
DEPLOYMENT_NAME="nginx-deployment"
SERVICE_NAME="nginx-service"
INGRESS_NAME="nginx-ingress"

# Delete Ingress
echo "Deleting Ingress '${INGRESS_NAME}'..."
kubectl delete ingress ${INGRESS_NAME} --namespace ${NAMESPACE} --ignore-not-found

# Delete Deployment
echo "Deleting Deployment '${DEPLOYMENT_NAME}'..."
kubectl delete deployment ${DEPLOYMENT_NAME} --namespace ${NAMESPACE} --ignore-not-found

# Delete Service
echo "Deleting Service '${SERVICE_NAME}'..."
kubectl delete service ${SERVICE_NAME} --namespace ${NAMESPACE} --ignore-not-found

# Delete TLS Secret
echo "Deleting Secret '${SECRET_NAME}'..."
kubectl delete secret ${SECRET_NAME} --namespace ${NAMESPACE} --ignore-not-found

# Verify Cleanup
echo "Verifying cleanup..."
kubectl get all --namespace ${NAMESPACE} | grep -E "${DEPLOYMENT_NAME}|${SERVICE_NAME}" || echo "No resources found."
kubectl get ingress --namespace ${NAMESPACE} | grep "${INGRESS_NAME}" || echo "No ingress found."
kubectl get secret --namespace ${NAMESPACE} | grep "${SECRET_NAME}" || echo "No secret found."

echo "Cleanup completed. Environment is clean."

