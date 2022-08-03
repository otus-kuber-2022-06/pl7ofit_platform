#!/bin/bash

set -eu

# create cluster
kind create cluster
kubectl wait deployment -n kube-system -l k8s-app=kube-dns --for condition=available --timeout=120s

# setup configuration for metallb 
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e 's/strictARP: .*/strictARP: true/' | \
sed -e 's/mode: .*/mode: "ipvs"/' | \
kubectl apply -f - -n kube-system
kubectl wait deployment -n kube-system -l k8s-app=kube-dns --for condition=available --timeout=120s

# recreate kube-proxy pods
kubectl --namespace kube-system delete pod --selector='k8s-app=kube-proxy'
kubectl wait deployment -n kube-system -l k8s-app=kube-dns --for condition=available --timeout=120s

# create deployment 3 replicas with template selector app=web
kubectl apply -f web-deploy.yaml
kubectl wait deployment/web -n default --for condition=available --timeout=120s

# create svc clusterip with selector app=web
#kubectl apply -f web-svc-cip.yaml


# install metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f metallb-config.yaml
kubectl wait deployment -n metallb-system -l app=metallb --for condition=available --timeout=120s

# create svc loadbalancer 80:8000 w ith label name=web-svc-lb and selector app=web
#kubectl apply -f web-svc-lb.yaml

# install ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/baremetal/deploy.yaml
kubectl wait deployment -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx --for condition=available --timeout=120s

# create svc ingress
kubectl apply -f nginx-lb.yaml

# create svc clusterip with selector app=web and name=web-svc
kubectl apply -f web-svc-headless.yaml
sleep 5


# create ingress with name=web and backend name=web-svc:8000
kubectl apply -f web-ingress.yaml
sleep 10

kubectl describe ing/web
kubectl logs -n metallb-system -f `kubectl get pod -n metallb-system --no-headers -l app=metallb,component=controller -o=jsonpath='{.items[0].metadata.name}'`