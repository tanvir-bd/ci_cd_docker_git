FROM node:18

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm install

# Copy Prisma schema
COPY prisma ./prisma/

# Set dummy DATABASE_URL and generate Prisma client
ENV DATABASE_URL="mysql://build:build@localhost:3306/builddb"
RUN npx prisma generate

# Copy application
COPY . .

# Debug: Check what was generated
RUN echo "=== Checking Prisma generation ===" && \
    ls -la node_modules/.prisma/client/ && \
    echo "=== Checking app structure ===" && \
    find . -name "*.ts" -o -name "*.js" | head -10

# Create next.config.js
RUN echo 'module.exports = { eslint: { ignoreDuringBuilds: true } }' > next.config.js

# Try to build with detailed output
RUN echo "=== Starting build ===" && \
    npm run build 2>&1 | tee build.log || (echo "=== Build failed, showing logs ===" && cat build.log && exit 1)

EXPOSE 3000
CMD ["npm", "start"]