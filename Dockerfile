FROM node:22-alpine3.20 as builder

WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .
# Create next.config.js to skip ESLint during build
RUN echo 'module.exports = { eslint: { ignoreDuringBuilds: true } }' > next.config.js
RUN npm run build
EXPOSE 3000
CMD [ "npm","run","start" ]