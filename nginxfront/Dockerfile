FROM nginx:stable-alpine
COPY default.conf /etc/nginx/conf.d
COPY localcerts/localhost.crt /etc/ssl/certs/localhost.crt
COPY localcerts/localhost.key /etc/ssl/private/localhost.key
EXPOSE 80/tcp
EXPOSE 443/tcp
CMD ["/bin/sh", "-c", "exec nginx -g 'daemon off;';"]
WORKDIR /usr/share/nginx/html