FROM node:alpine AS builder

WORKDIR /backend

COPY package.json .

RUN npm install -g pm2 && npm install --production

COPY . .

RUN adduser -D appuser

# Implementing non-root User

RUN chown -R appuser:appuser /backend 

CMD ["pm2-runtime", "start", "src/index.js", "--name", "jerney-backend"]
