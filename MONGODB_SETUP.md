# MongoDB Docker Commands for Prisma

## 🐳 Quick Start Commands

### 1. Start MongoDB with Replica Set (Single Command)
```bash
docker run -d --name mongo-replica \
  -p 27017:27017 \
  mongo:7 mongod --replSet rs0
```

### 2. Initialize Replica Set
```bash
# Wait 5 seconds for MongoDB to start
sleep 5

# Initialize the replica set
docker exec mongo-replica mongosh --eval "rs.initiate()"
```

### 3. Verify Replica Set Status
```bash
docker exec mongo-replica mongosh --eval "rs.status()"
```

## 🔧 Complete Setup Script

Use the provided script:
```bash
./start-mongo.sh
```

## 🛑 Cleanup Commands

### Stop and Remove Container
```bash
docker stop mongo-replica
docker rm mongo-replica
```

### Remove with Data Volume (if needed)
```bash
docker stop mongo-replica
docker rm mongo-replica
docker volume rm $(docker volume ls -q | grep mongo)
```

## 📋 Environment Configuration

### For Local Development (.env)
```env
DATABASE_URL="mongodb://127.0.0.1:27017/nextjs-auth?replicaSet=rs0"
```

### For Docker Compose
```yaml
DATABASE_URL="mongodb://mongodb:27017/nextjs-auth?replicaSet=rs0"
```

## 🚀 Docker Compose Setup

### Start Everything with Docker Compose
```bash
docker-compose up --build
```

### Initialize Replica Set in Docker Compose
```bash
# After containers are running
docker exec temp1_mongodb_1 mongosh --eval "rs.initiate()"
```

## 🔍 Troubleshooting

### Check Container Status
```bash
docker ps -a | grep mongo
```

### View MongoDB Logs
```bash
docker logs mongo-replica
```

### Connect to MongoDB Shell
```bash
docker exec -it mongo-replica mongosh
```

### Check Replica Set Configuration
```bash
docker exec mongo-replica mongosh --eval "rs.conf()"
```

## 📝 Important Notes

1. **Replica Set Name**: Always use `rs0` as the replica set name
2. **Connection String**: Must include `?replicaSet=rs0` parameter
3. **Initialization**: Replica set must be initialized before Prisma can connect
4. **Port**: Default MongoDB port is 27017
5. **Data Persistence**: Use volumes to persist data between container restarts

## 🎯 Prisma Commands

### Generate Prisma Client
```bash
npx prisma generate
```

### Push Schema to Database
```bash
npx prisma db push
```

### Open Prisma Studio
```bash
npx prisma studio
```
