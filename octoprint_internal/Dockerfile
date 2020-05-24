ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]


RUN \
    apk add --no-cache \
        nginx=1.16.1-r6 \
        haproxy

COPY nginx.conf /etc/nginx/nginx.conf
COPY haproxy.cfg /etc/haproxy/haproxy.cfg
COPY run.sh /
RUN chmod +x /run.sh

CMD ["/run.sh"]