kubectl create namespace elastic-system


kubectl create -f https://download.elastic.co/downloads/eck/2.15.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.15.0/operator.yaml


# monitor the operator logs
# kubectl -n elastic-system logs -f statefulset.apps/elastic-operator
