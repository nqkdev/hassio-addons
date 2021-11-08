ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
    apk add --no-cache \
        nginx \
        haproxy

COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh /
RUN chmod +x /run.sh

CMD ["/run.sh"]
