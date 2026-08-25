FROM node:alpine AS build

WORKDIR /frontend

COPY package.json .

RUN npm install --legacy-peer-deps

COPY . .

COPY nginx.conf etc/nginx/conf.d/default.conf

RUN npm run build

# 2nd stage
FROM nginx:alpine

RUN adduser -D appuser

COPY --from=build /frontend/dist /usr/share/nginx/html

RUN chown -R appuser:appuser /usr/share/nginx

COPY nginx.conf /etc/nginx/conf.d/default.conf





