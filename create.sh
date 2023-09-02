#!/bin/bash

kind create cluster --wait 300s --config /dev/stdin <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
containerdConfigPatches:
- |-
    [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
    endpoint = ["http://192.168.128.1:5000"]
EOF

arkade install ingress-nginx

arkade install openfaas

kubectl rollout status -n openfaas deploy/gateway

docker exec kind-control-plane journalctl -u kubelet
