kubectl patch service elasticsearch-cluster-es-http -n elastic-system -p '{"spec": {"type": "LoadBalancer"}}'

kubectl patch service kibana-kb-http -n elastic-system -p '{"spec": {"type": "LoadBalancer"}}'


