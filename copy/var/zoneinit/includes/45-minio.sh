#!/usr/bin/env bash
# Configure minio service before startup

MINIO_ACCESS_KEY=$(/opt/core/bin/mdata-create-password.sh -l 20 -m minio_access_key)
MINIO_SECRET_KEY=$(/opt/core/bin/mdata-create-password.sh -m minio_secret_key)

svccfg -s network/minio:default setenv MINIO_ACCESS_KEY "${MINIO_ACCESS_KEY}"
svccfg -s network/minio:default setenv MINIO_SECRET_KEY "${MINIO_SECRET_KEY}"

svccfg -s network/minio:default setprop config/address = astring: "127.0.0.1:9000"
svccfg -s network/minio:default setprop config/data = astring: "/data/minio"

svcadm refresh network/minio:default
svcadm enable network/minio:default
