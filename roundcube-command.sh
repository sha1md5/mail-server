#!/bin/bash

cp -f /certs/cert1.pem /usr/local/share/ca-certificates/mailserver-cert.crt
cp -f /certs/chain1.pem /usr/local/share/ca-certificates/mailserver-chain.crt
cp -f /certs/fullchain1.pem /usr/local/share/ca-certificates/mailserver-fullchain.crt
chmod 664 /usr/local/share/ca-certificates/mailserver-*.crt

cp -f /config.additional/config.additional.inc.php /var/www/html/config/config.additional.inc.php
chmod 664 /var/www/html/config/config.additional.inc.php

update-ca-certificates

CONFIG_FILE="/var/www/html/config/config.inc.php"
INCLUDE_LINE="include(__DIR__ . '/config.additional.inc.php');"

if ! grep -qF "$INCLUDE_LINE" "$CONFIG_FILE"; then
  echo "$INCLUDE_LINE" >> "$CONFIG_FILE"
fi
