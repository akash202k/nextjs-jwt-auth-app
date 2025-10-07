#!/bin/bash

# Kubernetes Cleanup Script for Next.js JWT Auth App
# This script removes all deployed resources

set -e

echo "🧹 Starting cleanup..."

echo "🗑️ Removing application resources..."
kubectl delete -f k8s/ingress.yaml --ignore-not-found=true
kubectl delete -f k8s/service.yaml --ignore-not-found=true
kubectl delete -f k8s/deployment.yaml --ignore-not-found=true
kubectl delete -f k8s/secrets.yaml --ignore-not-found=true

echo "🗑️ Removing MongoDB resources..."
kubectl delete -f k8s/mongodb-service.yaml --ignore-not-found=true
kubectl delete -f k8s/mongodb-deployment.yaml --ignore-not-found=true
kubectl delete -f k8s/mongodb-pvc.yaml --ignore-not-found=true

echo "✅ Cleanup completed successfully!"
echo ""
echo "💡 Note: Persistent volumes may still exist. To remove them completely:"
echo "kubectl get pv"
echo "kubectl delete pv <volume-name>"
