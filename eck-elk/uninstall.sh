#!/bin/bash
set -e

echo "Starting uninstallation of ECK deployment..."

# Remove Kibana and Elasticsearch resources
echo "Removing Kibana and Elasticsearch resources..."
kubectl delete -f kibana.yaml --ignore-not-found=true
kubectl delete -f elasticsearch.yaml --ignore-not-found=true

# Remove ingress rules
echo "Removing ingress configurations..."
kubectl delete -f elasticsearch-ingress.yaml --ignore-not-found=true
kubectl delete -f kibana-ingress.yaml --ignore-not-found=true

# Remove configurations
echo "Removing configurations..."
kubectl delete -f elastic-config.yaml --ignore-not-found=true
kubectl delete -f network-policies.yaml --ignore-not-found=true

# Remove PV
echo "Removing persistent volume..."
kubectl delete -f pv-elasticsearch-data-0.yaml --ignore-not-found=true

# Remove ECK operator
echo "Removing ECK operator..."
kubectl delete -f https://download.elastic.co/downloads/eck/2.15.0/operator.yaml --ignore-not-found=true
kubectl delete -f https://download.elastic.co/downloads/eck/2.15.0/crds.yaml --ignore-not-found=true

# Remove secret
kibana delete secret -n elastic-system kibana-tl

# Remove namespace
echo "Removing elastic-system namespace..."
kubectl delete namespace elastic-system --ignore-not-found=true

# Optional: Clean up data directory
read -p "Do you want to remove the data directory? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Removing data directory..."
    sudo rm -rf /mnt/data/elasticsearch/data-0
fi

echo "Uninstallation completed successfully!" 
