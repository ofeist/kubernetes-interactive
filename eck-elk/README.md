# Elasticsearch and Kibana on Kubernetes (ECK)

This setup provides a production-ready Elasticsearch and Kibana deployment using the Elastic Cloud on Kubernetes (ECK) operator.

## Prerequisites

- Kubernetes cluster
- kubectl installed and configured
- Nginx Ingress Controller
- Storage provisioning capability
- Domain name pointing to your cluster (currently configured for `baba.local`)

## Quick Start

1. Create required directories and set permissions:
```bash
./create-pv-dirs.sh
```

2. Deploy the entire stack:
```bash
./initial.sh
```

3. Get the Elasticsearch password:
```bash
kubectl get secret elasticsearch-cluster-es-elastic-user -n elastic-system -o=jsonpath='{.data.elastic}' | base64 --decode; echo
```

## Access Services

- Elasticsearch: `https://baba.local/es/`
- Kibana: `https://baba.local/kibana/`

## Component Overview

### Elasticsearch
- Version: 8.16.1
- Single-node deployment
- Resources:
  - Memory: 2Gi
  - CPU: 1-2 cores
  - Storage: 10Gi
- JVM Heap: 1Gi

### Kibana
- Version: 8.16.1
- Single instance
- Resources:
  - Memory: 1-2Gi
  - CPU: 0.5-1 cores

## Configuration Files

- `elasticsearch.yaml`: Main Elasticsearch cluster configuration
- `kibana.yaml`: Kibana deployment configuration
- `elastic-config.yaml`: Common settings for both services
- `network-policies.yaml`: Network security policies
- `*-ingress.yaml`: Ingress configurations
- `pv-elasticsearch-data-0.yaml`: Persistent volume configuration

## Security Features

- Network policies enabled
- X-Pack security enabled
- Audit logging enabled
- TLS/SSL configured

## Monitoring

Check cluster health:
```bash
kubectl get elasticsearch -n elastic-system
kubectl get kibana -n elastic-system
kubectl get pods -n elastic-system
```

View logs:
```bash
# Elasticsearch logs
kubectl logs -f -n elastic-system -l elasticsearch.k8s.elastic.co/cluster-name=elasticsearch-cluster

# Kibana logs
kubectl logs -f -n elastic-system -l kibana.k8s.elastic.co/name=kibana
```

## Troubleshooting

1. If pods are stuck in pending:
   - Check PV/PVC status
   - Verify storage permissions
   - Check resource availability

2. If services are not accessible:
   - Verify ingress controller is running
   - Check ingress configurations
   - Ensure DNS resolution works

3. Common fixes:
```bash
# Restart pods if needed
kubectl delete pod <pod-name> -n elastic-system

# Check events
kubectl get events -n elastic-system
```

## Maintenance

Backup Elasticsearch data:
```bash
# Directory containing Elasticsearch data
/mnt/data/elasticsearch/data-0
```

## Notes

- This setup uses local storage (hostPath)
- Single node deployment (not highly available)
- Configured for development/testing environments
- Modify ingress hosts and security settings for production use

## License

This project is licensed under the [MIT License](LICENSE). 