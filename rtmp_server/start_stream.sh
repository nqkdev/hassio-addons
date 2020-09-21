#!/usr/bin/env bashio
set -e

DNS=$(bashio::addon.dns)
STREAM=$1

bashio::log.blue '
 __  ___        __      __   ___  __        ___  __  
|__)  |   |\/| |__)    /__` |__  |__) \  / |__  |__) 
|  \  |   |  | |       .__/ |___ |  \  \/  |___ |  \ 
                                                     '
bashio::log.blue "New stream found '$STREAM'"
bashio::log.blue "To enable this stream as camera in your HomeAssistant, add the following to your 'configuration.yaml' file:
camera:
    - platform: generic
        name: $STREAM Video
        still_image_url: http://$DNS:8080/thumbnail/$STREAM.jpg
        stream_source: rtmp://$DNS/live/$STREAM
        verify_ssl: false
        "

function finish {
    bashio::log.notice "Stream $STREAM is closed."
    rm -f /data/thumbnail/$STREAM.jpg
}

trap finish EXIT

/usr/bin/ffmpeg -i rtmp://localhost:1935/live/$STREAM -loglevel warning -y -update 1 -vf fps=1/5 /data/thumbnail/$STREAM.jpg