#!/bin/bash
set -e

echo "==> Applying Namespace..."
kubectl apply -f namespace.yml

echo "==> Applying ConfigMap..."
kubectl apply -f configMap.yml

echo "==> Applying Secret..."
kubectl apply -f secret.yml

echo "==> Applying PersistentVolume..."
kubectl apply -f pv.yml

echo "==> Applying PersistentVolumeClaim..."
kubectl apply -f pvc.yml

echo "==> Applying Deployment..."
kubectl apply -f deployment.yml

echo "==> Applying ClusterIP Service..."
kubectl apply -f clusterIp.yml

echo "==> Applying NodePort Service..."
kubectl apply -f nodeport.yml

echo "==> Applying HorizontalPodAutoscaler..."
kubectl apply -f hpa.yml

echo ""
echo "==> All resources applied successfully!"
echo "==> Waiting for deployment to be ready..."
kubectl rollout status deployment/todoapp -n todoapp