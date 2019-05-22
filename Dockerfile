# stage 1, build angular app in node container
FROM node:latest as node
WORKDIR /app
# to keep node dependencies and our app/src in seperate conainer layers
COPY package.json package.json 
RUN npm install
COPY . .
RUN npx ng build --prod

# stage 2, copy compiled assets from node container & configure nginx to serve them
FROM nginx:alpine
LABEL author="Sigitas Pleikys"
VOLUME /var/cache/nginx
WORKDIR /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/nginx.conf
RUN rm -r /usr/share/nginx/html/*
COPY --from=node /app/dist/nginx2 /usr/share/nginx/html

# docker build --rm -f "Dockerfile" -t img-name:tag . 
# docker run -d -p 8080:8080/tcp img-name:tag