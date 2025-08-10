#!/usr/bin/env bash

set -euo pipefail

echo -n pass | saslpasswd2 -c -p -u localhost smtpuser
chown root:sasl /etc/sasldb2
chmod 640 /etc/sasldb2

exec /usr/sbin/postfix start-fg


