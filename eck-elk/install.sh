#!/bin/bash
set -e

# Create namespace
kubectl create namespace elastic-system

# Add labels to namespace
kubectl label namespace elastic-system name=elastic-system purpose=logging

# Create CRDs and operator
kubectl create -f https://download.elastic.co/downloads/eck/2.15.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.15.0/operator.yaml

# Create storage directories with proper permissions
./create-pv-dirs.sh

# Apply configurations
kubectl apply -f elastic-config.yaml
kubectl apply -f network-policies.yaml
kubectl apply -f pv-elasticsearch-data-0.yaml
kubectl apply -f elasticsearch.yaml
kubectl apply -f kibana.yaml

# Create Kibana encryption key secret
kubectl apply -f kibana-secret.yaml

# Wait for Elasticsearch to be ready
echo "Waiting for Elasticsearch cluster to be ready..."
kubectl wait --for=condition=ready elasticsearch elasticsearch-cluster -n elastic-system --timeout=300s

# Apply ingress rules
kubectl apply -f elasticsearch-ingress.yaml
kubectl apply -f kibana-ingress.yaml

echo "Deployment completed successfully!" 