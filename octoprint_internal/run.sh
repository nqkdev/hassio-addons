#!/usr/bin/env bashio
set -e

WAIT_PIDS=()

# Start Nginx proxy
bashio::log.info "Starting Nginx..."
ingress_entry=$(bashio::addon.ingress_entry)
sed -i "s#%%base_path%%#${ingress_entry}#g" /etc/nginx/nginx.conf
nginx &
WAIT_PIDS+=($!)

# Start HAProxy
# bashio::log.info "Starting HAProxy..."
# ingress_entry=$(bashio::addon.ingress_entry)
# sed -i "s#%%base_path%%#${ingress_entry}#g" /etc/haproxy/haproxy.cfg
# haproxy -db -f /etc/haproxy/haproxy.cfg &
# WAIT_PIDS+=($!)

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