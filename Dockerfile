FROM node:18
WORKDIR /app
COPY package*.json ./
# Install ALL dependencies (not just production)
RUN npm install
COPY . .

# Create next.config.js to skip ESLint during build
RUN echo 'module.exports = { eslint: { ignoreDuringBuilds: true } }' > next.config.js

RUN npm run build
EXPOSE 3000
CMD [ "npm","run","start" ]