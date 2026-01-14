#!/bin/bash
set -e

DOMAIN="${DOMAIN:-lev.local}"
SSL_DIR="/etc/ssl/private"
CERT_NAME="$DOMAIN"

apt update && apt install -y apache2 openssl

cat > /tmp/openssl.cnf <<EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
req_extensions = v3_req

[dn]
CN = $DOMAIN

[v3_req]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always

[alt_names]
DNS.1 = $DOMAIN
DNS.2 = www.$DOMAIN
EOF

openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout "$SSL_DIR/$CERT_NAME.key" \
  -out "$SSL_DIR/$CERT_NAME.crt" \
  -config /tmp/openssl.cnf \
  -extensions v3_req

mkdir -p /vagrant/ssl
cp "$SSL_DIR/$CERT_NAME.crt" /vagrant/ssl/

a2enmod ssl rewrite
cat > /etc/apache2/sites-available/${DOMAIN}.conf <<EOF
<VirtualHost *:80>
    ServerName ${DOMAIN}
    ServerAlias www.${DOMAIN}
    Redirect permanent / https://${DOMAIN}/
</VirtualHost>

<VirtualHost *:443>
    ServerName ${DOMAIN}
    DocumentRoot /var/www/html
    SSLEngine on
    SSLCertificateFile ${SSL_DIR}/${CERT_NAME}.crt
    SSLCertificateKeyFile ${SSL_DIR}/${CERT_NAME}.key

    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>

    RewriteEngine On
    RewriteCond %{HTTP_HOST} ^www\.${DOMAIN}$ [NC]
    RewriteRule ^(.*)$ https://${DOMAIN}/$1 [R=301,L]
</VirtualHost>
EOF

a2ensite ${DOMAIN}.conf
a2dissite 000-default.conf
systemctl restart apache2

echo "Сервер $DOMAIN готов."
