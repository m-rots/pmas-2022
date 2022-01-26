#!/bin/sh
set -e

CERT_FILE="./private.pem"

redis-server \
    --port 0 --tls-port 6379 \
    --tls-cert-file $CERT_FILE \
    --tls-key-file $CERT_FILE \
    --tls-ca-cert-file $CERT_FILE \
    --tls-auth-clients no