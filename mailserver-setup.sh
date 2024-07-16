#!/bin/bash

# Add email accounts
docker exec -ti mailserver setup email add {MAIL_USER}@{DOMAIN.TLD} "$(echo -n '{MAIL_PASSWORD}' | awk '{print $1}')"
docker exec -ti mailserver setup alias add postmaster@{DOMAIN.TLD} {MAIL_USER}@{DOMAIN.TLD}
docker exec -ti mailserver setup alias add dmarc-reports@{DOMAIN.TLD} {MAIL_USER}@{DOMAIN.TLD}

docker exec -ti mailserver setup config dkim keysize 2048 domain '{DOMAIN.TLD}'
sudo cat ./config/opendkim/keys/{DOMAIN.TLD}/mail.txt

docker exec -ti roundcube /bin/bash /usr/local/bin/roundcube-command.sh
