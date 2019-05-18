FROM nginx:alpine
LABEL author="Sigitas Pleikys"
VOLUME /var/cache/nginx
WORKDIR /app
COPY ./config/nginx.conf /etc/nginx/nginx.conf
RUN rm -r /usr/share/nginx/html/*
COPY ./dist/nginx2 /usr/share/nginx/html/test
COPY ./test2 /usr/share/nginx/html/test2

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
