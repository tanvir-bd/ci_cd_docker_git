FROM node:22-alpine3.20 as builder

WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .
# Skip ESLint entirely and see if there are other issues
RUN SKIP_ENV_VALIDATION=true npm run build
RUN npm run build
EXPOSE 3000
CMD [ "npm","run","start" ]