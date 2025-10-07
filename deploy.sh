#!/bin/bash

# Kubernetes Deployment Script for Next.js JWT Auth App
# This script deploys the application to Minikube

set -e

echo "🚀 Starting Kubernetes deployment..."

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl is not installed. Please install kubectl first."
    exit 1
fi

# Check if minikube is running
if ! minikube status &> /dev/null; then
    echo "❌ Minikube is not running. Starting Minikube..."
    minikube start
fi

echo "📦 Deploying MongoDB..."
kubectl apply -f k8s/mongodb-pvc.yaml
kubectl apply -f k8s/mongodb-deployment.yaml
kubectl apply -f k8s/mongodb-service.yaml

echo "⏳ Waiting for MongoDB to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/mongodb

echo "🔐 Deploying application secrets..."
kubectl apply -f k8s/secrets.yaml

echo "🚀 Deploying Next.js application..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

echo "🌐 Setting up ingress..."
kubectl apply -f k8s/ingress.yaml

echo "⏳ Waiting for application to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/nextjs-jwt-auth-app

echo "✅ Deployment completed successfully!"
echo ""
echo "📋 To access the application:"
echo "1. Get the service URL: minikube service nextjs-jwt-auth-app-service --url"
echo "2. Or add to /etc/hosts: echo \"\$(minikube ip) nextjs-app.local\" | sudo tee -a /etc/hosts"
echo "3. Then visit: http://nextjs-app.local"
echo ""
echo "🔍 To check pod status: kubectl get pods -l app=nextjs-jwt-auth-app"
echo "📊 To view logs: kubectl logs -l app=nextjs-jwt-auth-app"
