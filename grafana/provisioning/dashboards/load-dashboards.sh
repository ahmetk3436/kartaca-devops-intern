#!/bin/bash

GRAFANA_URL="http://localhost:3000"
GRAFANA_USER="admin"
GRAFANA_PASSWORD="admin"

# Wait for Grafana to start
until $(curl --output /dev/null --silent --head --fail ${GRAFANA_URL}); do
    printf '.'
    sleep 5
done

# Login to Grafana
curl --cookie-jar /tmp/grafana-login-cookie.txt \
     --data "user=${GRAFANA_USER}&password=${GRAFANA_PASSWORD}" \
     ${GRAFANA_URL}/login

# Load datasources
curl --cookie /tmp/grafana-login-cookie.txt \
     --header "Content-Type: application/json" \
     --data-binary @./provisioning/datasources/prometheus.yml \
     ${GRAFANA_URL}/api/datasources

# Load dashboards
for file in ./provisioning/dashboards/*.json; do
    curl --cookie /tmp/grafana-login-cookie.txt \
         --header "Content-Type: application/json" \
             --data-binary "@${file}" \
             ${GRAFANA_URL}/api/dashboards/db
             done

echo "All dashboards loaded successfully!"
