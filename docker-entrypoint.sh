#!/bin/sh
set -e

# When OPENCLAW_STATE_DIR is set (container/cloud platforms), seed a default
# config so the gateway binds to 0.0.0.0 instead of loopback. Without this,
# reverse proxies (Render, Railway, etc.) can't reach the container.
state_dir="${OPENCLAW_STATE_DIR:-}"
if [ -n "$state_dir" ]; then
  mkdir -p "$state_dir"
  config="$state_dir/openclaw.json"
  if [ ! -f "$config" ]; then
    printf '{"gateway":{"mode":"local","bind":"lan","controlUi":{"dangerouslyAllowHostHeaderOriginFallback":true}}}' > "$config"
  fi
fi

exec "$@"
