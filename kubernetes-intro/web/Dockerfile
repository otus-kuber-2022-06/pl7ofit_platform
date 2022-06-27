FROM nginx:alpine
RUN printf '\n\
          worker_processes  auto;\n\
          error_log  /dev/stderr;\n\
          pid        /tmp/nginx.pid;\n\
          events {worker_connections  1024;}\n\
          http \n\
          {\n\
            access_log  /dev/stdout;\n\
            sendfile        on;\n\
            keepalive_timeout  65;\n\
            server{\n\
              listen 8000;\n\
              location / \n\
              {\n\
                root /app;\n\
              }\n\
            }\n\
          }\n\
          ' > /etc/nginx/nginx_custom.conf
RUN mkdir /app && \
    adduser -D -H -s /bin/false -u 1001 alpine && \
    chown -R alpine:alpine /app && \
    chown -R alpine:alpine /var/cache/nginx/
USER alpine
EXPOSE 8000
ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx_custom.conf", "-g", "daemon off;"]

