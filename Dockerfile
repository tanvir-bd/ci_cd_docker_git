FROM node:22-alpine3.20 as builder

WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .
# Add this line to ignore ESLint errors during build
RUN echo "app/generated/\n**/generated/" > .eslintignore
RUN npm run build
EXPOSE 3000
CMD [ "npm","run","start" ]