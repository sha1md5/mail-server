# Used containers
- https://hub.docker.com/r/mailserver/docker-mailserver -> https://github.com/docker-mailserver/docker-mailserver
- https://hub.docker.com/r/roundcube/roundcubemail/ -> https://github.com/roundcube/roundcubemail

# Configuration
- {DOMAIN.TLD} - you domain name.
- {A_RECORD_IP} - your IPv4 address from A Record or A+ Dynamic DNS Record.
- {DKIM_PUBLIC_KEY} - DKIM public key shown after ./setup.sh (sudo cat ./config/opendkim/keys/{DOMAIN.TLD}/mail.txt). \
  Key should be single line string without quotes or spaces.
- {MAIL_USER} - main mail user.
- {MAIL_PASSWORD} - main mail user password as plain text.

Update your path to certificates in docker-compose.yml file. \
For better security and isolation replace local volume paths to docker local drivers.

# Installation
```shell
docker compose up
./mailserver-setup.sh
```
Stop container and proceed to [# Domain configuration](#domain-configuration).

After configuration set and propagated (test with dig) start containers again. \
If everything works run containers as daemon with -d argument. \
For additional possible configuration check 
```shell
docker exec -ti mailserver setup help
```


# Domain configuration
Set minimum possible TTL to propagate records fast as possible.

- CAA Record @ issue "letsencrypt.org"
- CNAME Record mail {DOMAIN.TLD}.
- TXT Record @ v=spf1 ip4:{A_RECORD_IP} include:_spf.google.com mx -all
- TXT Record _dmarc v=DMARC1; p=reject; pct=5; ri=86400; sp=reject; rua=mailto:dmarc-reports@{DOMAIN.TLD}; ruf=mailto:dmarc-reports@{DOMAIN.TLD}; fo=1; rf=afrf; adkim=s; aspf=s;
- TXT Record mail._domainkey v=DKIM1; h=sha256; k=rsa; p={DKIM_PUBLIC_KEY}
- MX Record @ mail.{DOMAIN.TLD}. 0

# Services to test mail server
- https://toolbox.googleapps.com/apps/dig
- https://toolbox.googleapps.com/apps/checkmx
- https://www.ssllabs.com/ssltest/index.html
- https://mxtoolbox.com/emailhealth/
- https://www.mail-tester.com
- https://www.experte.com/spam-checker
- https://spamcheck.postmarkapp.com/
- http://isnotspam.com/
- https://www.mailgenius.com/
- https://glockapps.com/inbox-email-tester
- https://glockapps.com/domain-checker/
- https://www.mimecast.com/products/dmarc-analyzer/spf-record-check/
- https://multirbl.valli.org/
- https://internet.nl/test-mail/

# Additional protection for Roundcube
- https://mailvelope.com
