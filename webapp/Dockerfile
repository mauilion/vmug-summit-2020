FROM  gliderlabs/alpine
RUN   apk-install nginx
RUN   mkdir -p /run/nginx
COPY  index.html /usr/share/nginx/html/
COPY  default.conf /etc/nginx/conf.d/default.conf
COPY  resources /usr/share/nginx/html/resources/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
