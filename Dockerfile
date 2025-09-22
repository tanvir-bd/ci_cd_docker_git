FROM node:18
WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm install

# Copy Prisma schema first
COPY prisma ./prisma/
RUN npx prisma generate

# Copy rest of the application
COPY . .

# Set env var during build (from ARG)
ARG DATABASE_URL
ENV DATABASE_URL=$DATABASE_URL

RUN npm run build

EXPOSE 3000
CMD [ "npm","run","start" ]
