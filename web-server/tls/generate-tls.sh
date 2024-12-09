#!/bin/bash

# Variables
CERT_NAME="tls"
NAMESPACE="default"
SECRET_NAME="nginx-tls-secret"

# Generate TLS Certificate and Key
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "${CERT_NAME}.key" \
  -out "${CERT_NAME}.crt" \
  -subj "/CN=baba.local/O=baba.local"

# Create Kubernetes Secret
kubectl create secret tls ${SECRET_NAME} \
  --cert="${CERT_NAME}.crt" \
  --key="${CERT_NAME}.key" \
  --namespace ${NAMESPACE}

# Output Secret Name
echo "TLS Secret '${SECRET_NAME}' created in namespace '${NAMESPACE}'."

# Cleanup local files (optional)
rm -f "${CERT_NAME}.crt" "${CERT_NAME}.key"

# End

