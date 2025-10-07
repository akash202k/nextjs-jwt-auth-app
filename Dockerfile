# ---------- Build stage ----------
FROM node:18-alpine AS builder
WORKDIR /app

# Install dependencies needed for Next.js and Prisma
RUN apk add --no-cache libc6-compat openssl

# Copy everything (respects .dockerignore)
COPY . .

# Install dependencies, generate Prisma, and build
# Set dummy DATABASE_URL only for build (not persisted)
RUN DATABASE_URL="mongodb://dummy:27017/dummy" npm ci && \
    DATABASE_URL="mongodb://dummy:27017/dummy" npx prisma generate && \
    DATABASE_URL="mongodb://dummy:27017/dummy" npm run build

# ---------- Runtime stage ----------
FROM node:18-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV PORT=3000

# Install runtime dependencies
RUN apk add --no-cache libc6-compat openssl

# Copy only what's needed to run
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma
COPY --from=builder /app/node_modules/@prisma ./node_modules/@prisma
COPY --from=builder /app/package.json ./package.json

# Copy public folder if it exists
# COPY --from=builder /app/public ./public

EXPOSE 3000
CMD ["node", "server.js"]