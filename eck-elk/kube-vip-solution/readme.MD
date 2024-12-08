# Elasticsearch Cloud on Kubernetes (ECK) Deployment

This repository contains configuration files for deploying Elasticsearch and Kibana using the Elastic Cloud on Kubernetes (ECK) operator.

## Architecture Overview

- **Version**: Elasticsearch/Kibana 8.16.1
- **Deployment Type**: Single-node Elasticsearch cluster (non-HA)
- **Components**:
  - Elasticsearch node (master+data)
  - Kibana instance
  - kube-vip LoadBalancer (IP: 192.168.0.230)

## Prerequisites

1. Kubernetes cluster
2. ECK operator installed
3. `kubectl` configured
4. Storage provisioning capability
5. kube-vip configured in your cluster

## Directory Structure

```
.
├── elasticsearch.yaml         # Elasticsearch cluster configuration
├── elasticsearch-lb.yaml     # LoadBalancer service for Elasticsearch
├── kibana.yaml              # Kibana deployment configuration
├── create-pv-dirs.sh        # Script to create storage directories
└── README.md                # This file
```

## Deployment Steps

0. OptionalRun initial.sh

1. Create storage directories:

```bash
./create-pv-dirs.sh
```

2. Create the namespace:

```bash
kubectl create namespace elastic-system
```

3. Deploy Elasticsearch:

```bash
kubectl apply -f elasticsearch.yaml
```

4. Deploy LoadBalancer service:

```bash
kubectl apply -f elasticsearch-lb.yaml
```

5. Deploy Kibana:

```bash
kubectl apply -f kibana.yaml
```

## Current Configuration

### Resource Allocation

#### Elasticsearch
- Memory Request: 2Gi
- Memory Limit: 2Gi
- CPU Request: 1
- CPU Limit: 2
- JVM Heap: 1Gi

#### Kibana
- Memory Request: 1Gi
- Memory Limit: 2Gi
- CPU Request: 500m
- CPU Limit: 1

### Storage
- Type: Local storage with manual provisioning
- Size: 10Gi
- Storage Class: manual

### Network
- LoadBalancer IP: 192.168.0.230
- Elasticsearch Port: 9200
- Kibana Port: 5601

## Recommendations for Production

### Security Enhancements
1. Enable TLS (currently disabled)
2. Configure proper authentication
3. Implement network policies
4. Use secrets management for sensitive data

### High Availability
1. Increase node count for Elasticsearch
2. Configure proper master/data node separation
3. Implement proper backup strategy

### Resource Management
1. Adjust JVM heap to 50% of container memory
2. Monitor and adjust resource limits based on usage
3. Implement proper resource quotas

### Storage
1. Use production-grade storage class
2. Implement backup and restore procedures
3. Monitor disk usage and implement alerts

### Monitoring
1. Add health checks:
   - Readiness probe
   - Liveness probe
2. Set up monitoring for:
   - Cluster health
   - Resource usage
   - Performance metrics

### Network Configuration
1. Consider separate IPs for Elasticsearch and Kibana
2. Implement proper ingress controllers
3. Configure network policies
4. Set up SSL/TLS termination

## Maintenance

### Checking Cluster Health

```bash
kubectl get elasticsearch -n elastic-system
kubectl get kibana -n elastic-system
kubectl get pods -n elastic-system
```

### Accessing Services
- Elasticsearch: http://192.168.0.230:9200
- Kibana: http://192.168.0.230:5601

### Getting Credentials

```bash
kubectl get secret elasticsearch-cluster-es-elastic-user -n elastic-system -o=jsonpath='{.data.elastic}' | base64 --decode
```

## Known Limitations

1. Single-node deployment (no HA)
2. Local storage dependency
3. Shared LoadBalancer IP
4. TLS disabled (not recommended for production)

## Troubleshooting

1. Check pod status:

```bash
kubectl describe pod -n elastic-system
```

2. View logs:

```bash
kubectl logs -f -n elastic-system <pod-name>

```kube-vip-solution/readme.MD

3. Common issues:
   - Storage permission problems
   - Resource constraints
   - Network connectivity issues

## Contributing

Feel free to submit issues and enhancement requests!

## License

[Specify your license here]
```

This README provides a comprehensive overview of your deployment, including current configuration, recommendations, and maintenance procedures. You can customize it further based on your specific needs or requirements.

Would you like me to add or modify any sections?
