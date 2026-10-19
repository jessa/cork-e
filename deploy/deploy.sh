#!/bin/bash
# Deploy the cork-e.eu website to the server (set up with ../server first).
#
#   deploy/deploy.sh          upload site/ and the Caddy site file, reload Caddy
#
# Server: SERVER_HOST (default deploy@app.cork-e.eu). The GitHub Action
# (.github/workflows/deploy.yml) uploads site/ only, with a restricted key.
set -euo pipefail
cd "$(dirname "$0")/.."

HOST="${SERVER_HOST:-deploy@app.cork-e.eu}"

ssh "$HOST" "install -d /opt/www/cork-e /opt/www/cork-e/site"
rsync -az --delete --exclude .DS_Store site/ "$HOST:/opt/www/cork-e/site/"
rsync -az deploy/cork-e-site.caddy "$HOST:/opt/edge/sites/cork-e-site.caddy"
ssh "$HOST" 'cd /opt/edge && docker compose exec -T caddy caddy reload --config /etc/caddy/Caddyfile'
