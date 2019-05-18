# stage 1, build angular app in node container
FROM node:latest as node
LABEL author="Sigitas Pleikys"
WORKDIR /app
COPY package.json package.json
RUN npm install
COPY . .
RUN npm run build -- --prod

# stage 2, copy compiled assets from node container & configure nginx to serve them
FROM nginx:alpine
LABEL author="Sigitas Pleikys"
VOLUME /var/cache/nginx
WORKDIR /app
COPY ./config/nginx.conf /ect/nginx/conf.d/default.conf
COPY --from=node /app/dist /usr/share/nginx/html