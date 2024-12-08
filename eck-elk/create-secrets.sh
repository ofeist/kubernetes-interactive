#!/bin/bash
set -e

# Generate self-signed certificate for Kibana
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout kibana-tls.key \
  -out kibana-tls.crt \
  -subj "/CN=kibana.elastic-system.svc"

# Create TLS secret
kubectl create secret tls kibana-tls \
  --namespace elastic-system \
  --key kibana-tls.key \
  --cert kibana-tls.crt

# Clean up temporary files
rm kibana-tls.key kibana-tls.crt

echo "Kibana secrets created successfully!" 