#!/bin/bash
set -e

DOMAIN="${DOMAIN:-lev.local}"
SERVER_IP="${SERVER_IP:-192.168.56.10}"

echo "$SERVER_IP $DOMAIN www.$DOMAIN" >> /etc/hosts

CERT_PATH="/vagrant/ssl/${DOMAIN}.crt"

if [ ! -f "$CERT_PATH" ]; then
  echo "Сертификат не найден: $CERT_PATH"
  exit 1
fi

cp "$CERT_PATH" /usr/local/share/ca-certificates/
update-ca-certificates

echo "Домен $DOMAIN добавлен в hosts и сертификат доверен."