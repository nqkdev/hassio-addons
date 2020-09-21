ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
    apk add --no-cache \
        nginx \
        nginx-mod-rtmp \
        ffmpeg

RUN mkdir -p /stream /data /static

COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh start_stream.sh /
COPY static /static

RUN chmod +x /run.sh

EXPOSE 1935 8080

CMD ["/run.sh"]