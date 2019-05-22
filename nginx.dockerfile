FROM nginx:alpine
LABEL author="Sigitas Pleikys"
VOLUME /var/cache/nginx
WORKDIR /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/nginx.conf
RUN rm -r /usr/share/nginx/html/*
COPY /dist/nginx2 /usr/share/nginx/html

# image for private docker registry and push it 
#  docker build --rm -f "nginx.dockerfile" -t 127.0.0.1:8082/test-img:1 
#  docker login -u admin -p admin123 127.0.0.1:8082
#  docker push 127.0.0.1:8082/test-img:1 