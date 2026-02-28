#!/bin/bash
set -e

echo "==> Applying Namespace..."
kubectl apply -f .infrastructure/namespace.yml

echo "==> Applying ConfigMap..."
kubectl apply -f .infrastructure/confgiMap.yml

echo "==> Applying Secret..."
kubectl apply -f .infrastructure/secret.yml

echo "==> Applying PersistentVolume..."
kubectl apply -f .infrastructure/pv.yml

echo "==> Applying PersistentVolumeClaim..."
kubectl apply -f .infrastructure/pvc.yml

echo "==> Applying Deployment..."
kubectl apply -f .infrastructure/deployment.yml

echo "==> Applying ClusterIP Service..."
kubectl apply -f .infrastructure/clusterIp.yml

echo "==> Applying NodePort Service..."
kubectl apply -f .infrastructure/nodeport.yml

echo "==> Applying HorizontalPodAutoscaler..."
kubectl apply -f .infrastructure/hpa.yml

echo ""
echo "==> All resources applied successfully!"
echo "==> Waiting for deployment to be ready..."
kubectl rollout status deployment/todoapp -n todoapp