#!/usr/bin/env bashio
set -e

WAIT_PIDS=()

# Create thumbnail folder
mkdir -p /data/thumbnail

# Start Nginx proxy
bashio::log.info "Starting Nginx..."
ingress_entry=$(bashio::addon.ingress_entry)
sed -i "s#%%base_path%%#${ingress_entry}#g" /etc/nginx/nginx.conf
nginx &
WAIT_PIDS+=($!)

# Register stop
function stop_addon() {
    bashio::log.debug "Kill Processes..."
    kill -15 "${WAIT_PIDS[@]}"

    wait "${WAIT_PIDS[@]}"
    bashio::log.debug "Done."
}
trap "stop_addon" SIGTERM SIGHUP

# Wait until all is done
bashio::log.info "Running!"
wait "${WAIT_PIDS[@]}"