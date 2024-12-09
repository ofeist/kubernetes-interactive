openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout kibana-tls.key -out kibana-tls.crt \
  -subj "/CN=baba.local/O=baba.local"

kubectl create secret tls kibana-tls \
  --cert=kibana-tls.crt --key=kibana-tls.key -n elastic-system

# Clean up temporary files
rm kibana-tls.key kibana-tls.crt

echo "Kibana secrets created successfully!" 
