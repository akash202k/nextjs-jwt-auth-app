#!/bin/bash

# MongoDB Replica Set Setup Script
# This script starts MongoDB as a replica set and initializes it

echo "🐳 Starting MongoDB with replica set..."

# Start MongoDB container with replica set
docker run -d --name mongo-replica \
  -p 27017:27017 \
  mongo:7 mongod --replSet rs0

echo "⏳ Waiting for MongoDB to start..."
sleep 5

echo "🔧 Initializing replica set..."
docker exec mongo-replica mongosh --eval "rs.initiate()"

echo "✅ MongoDB replica set is ready!"
echo ""
echo "📋 Connection string: mongodb://localhost:27017/nextjs-auth?replicaSet=rs0"
echo "🔍 To check replica set status: docker exec mongo-replica mongosh --eval 'rs.status()'"
echo "🛑 To stop: docker stop mongo-replica && docker rm mongo-replica"
