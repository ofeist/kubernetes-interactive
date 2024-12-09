#!/bin/bash

# Variables
NAMESPACE="default"

# Apply Deployment and Service
kubectl apply -f ../tls/nginx-deployment.yaml --namespace ${NAMESPACE}

# Apply Ingress with TLS
kubectl apply -f ../tls/nginx-ingress.yaml --namespace ${NAMESPACE}

# Output Status
echo "Nginx deployment with TLS applied in namespace '${NAMESPACE}'."

