# Next.js JWT Authentication App

A modern Next.js application with JWT-based authentication, MongoDB integration using Prisma, and Kubernetes deployment capabilities. This project demonstrates DevOps best practices including containerization, CI/CD with GitHub Actions, and Kubernetes orchestration.

## 🚀 Features

- **JWT Authentication**: Secure login/register with JWT tokens
- **Protected Routes**: Profile page with user details
- **MongoDB Integration**: Database operations using Prisma ORM
- **Docker Containerization**: Multi-stage optimized Docker builds
- **Kubernetes Ready**: Complete K8s manifests for deployment
- **CI/CD Pipeline**: Automated builds and deployments with GitHub Actions
- **Health Checks**: Application health monitoring endpoints
- **TypeScript**: Full type safety throughout the application

## 📋 Prerequisites

- Node.js 18+ 
- Docker and Docker Compose
- MongoDB (local or cloud)
- Kubernetes cluster (Minikube for local development)
- Git

## 🛠️ Local Development Setup

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd nextjs-jwt-auth-app
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Environment Configuration

Copy the environment template and configure your variables:

```bash
cp env.example .env
```

Update the `.env` file with your configuration:

```env
DATABASE_URL="mongodb://localhost:27017/nextjs-auth"
JWT_SECRET="your-super-secret-jwt-key-change-this-in-production"
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="your-nextauth-secret-change-this-in-production"
NODE_ENV="development"
PORT=3000
```

### 4. Database Setup

Generate Prisma client and push schema to database:

```bash
npx prisma generate
npx prisma db push
```

### 5. Start Development Server

```bash
npm run dev
```

The application will be available at `http://localhost:3000`

## 🐳 Docker Development

### Using Docker Compose (Recommended)

```bash
docker-compose up --build
```

This will start:
- Next.js application on port 3000
- MongoDB on port 27017

### Manual Docker Build

```bash
# Build the image
docker build -f Dockerfile.dev -t nextjs-jwt-auth-app:dev .

# Run the container
docker run -p 3000:3000 --env-file .env nextjs-jwt-auth-app:dev
```

## ☸️ Kubernetes Deployment with Minikube

### 1. Start Minikube

```bash
minikube start
```

### 2. Enable Ingress (Optional)

```bash
minikube addons enable ingress
```

### 3. Deploy MongoDB (if not using external service)

```bash
kubectl apply -f k8s/mongodb-deployment.yaml
kubectl apply -f k8s/mongodb-service.yaml
```

### 4. Update Secrets

Edit `k8s/secrets.yaml` with your actual values:

```yaml
stringData:
  database-url: "mongodb://mongodb-service:27017/nextjs-auth"
  jwt-secret: "your-actual-jwt-secret"
  nextauth-secret: "your-actual-nextauth-secret"
```

### 5. Deploy Application

```bash
# Apply all Kubernetes manifests
kubectl apply -f k8s/secrets.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
```

### 6. Access the Application

```bash
# Get the service URL
minikube service nextjs-jwt-auth-app-service --url

# Or if using ingress
echo "$(minikube ip) nextjs-app.local" | sudo tee -a /etc/hosts
# Then visit http://nextjs-app.local
```

## 🔧 Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run start` - Start production server
- `npm run lint` - Run ESLint
- `npm run db:generate` - Generate Prisma client
- `npm run db:push` - Push schema to database
- `npm run db:studio` - Open Prisma Studio

## 📁 Project Structure

```
├── src/
│   ├── app/                 # Next.js App Router
│   │   ├── api/            # API routes
│   │   │   ├── auth/       # Authentication endpoints
│   │   │   ├── profile/    # Profile API
│   │   │   └── health/     # Health check
│   │   ├── profile/        # Protected profile page
│   │   └── globals.css     # Global styles
│   ├── components/         # React components
│   └── lib/               # Utility functions
│       ├── auth.ts        # JWT utilities
│       ├── password.ts    # Password hashing
│       └── prisma.ts      # Database client
├── prisma/
│   └── schema.prisma      # Database schema
├── k8s/                   # Kubernetes manifests
├── .github/workflows/     # GitHub Actions
├── Dockerfile            # Production Docker image
├── Dockerfile.dev        # Development Docker image
└── docker-compose.yml    # Local development setup
```

## 🔐 Authentication Flow

1. **Registration**: Users can create accounts with email/password
2. **Login**: JWT tokens are generated and stored as HTTP-only cookies
3. **Protected Routes**: Profile page requires valid authentication
4. **Logout**: Tokens are invalidated and cookies cleared

## 🏥 Health Monitoring

The application includes health check endpoints:

- `GET /api/health` - Application health status
- Kubernetes liveness and readiness probes configured

## 🚀 CI/CD Pipeline

GitHub Actions workflow automatically:

1. Builds Docker image on push to main branch
2. Pushes to GitHub Container Registry (GHCR)
3. Supports multi-platform builds (AMD64/ARM64)
4. Uses build cache for faster builds

## 🔧 Configuration

### Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `DATABASE_URL` | MongoDB connection string | Yes |
| `JWT_SECRET` | Secret for JWT signing | Yes |
| `NEXTAUTH_SECRET` | NextAuth.js secret | Yes |
| `NODE_ENV` | Environment mode | Yes |
| `PORT` | Application port | No (default: 3000) |

### Kubernetes Configuration

- **Replicas**: 3 instances for high availability
- **Resources**: CPU/Memory limits configured
- **Health Checks**: Liveness and readiness probes
- **Secrets**: Environment variables stored securely

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection**: Ensure MongoDB is running and accessible
2. **JWT Errors**: Check JWT_SECRET is set correctly
3. **Build Failures**: Verify all dependencies are installed
4. **Kubernetes Issues**: Check pod logs with `kubectl logs <pod-name>`

### Debug Commands

```bash
# Check application logs
kubectl logs -l app=nextjs-jwt-auth-app

# Check pod status
kubectl get pods -l app=nextjs-jwt-auth-app

# Check service endpoints
kubectl get endpoints nextjs-jwt-auth-app-service
```

## 📝 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/auth/register` | User registration |
| POST | `/api/auth/login` | User login |
| POST | `/api/auth/logout` | User logout |
| GET | `/api/profile` | Get user profile (protected) |
| GET | `/api/health` | Health check |

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 📞 Support

For questions or issues, please open a GitHub issue or contact the development team.

---

**DevOps Assessment Submission** - Containerized Next.js Application with JWT Authentication and Kubernetes Deployment
