#!/usr/bin/env bash

set -euo pipefail

if [ -f ./testbootstrap.php ]; then
  cp -f ./testbootstrap.php ./PHPMailer/test/testbootstrap.php
fi

# Environment for relay-based tests (e.g. CRAM-MD5)
export RELAY_HOST=postfix
export RELAY_PORT=25
export RELAY_USERNAME="smtpuser@localhost"
export RELAY_PASSWORD="pass"

./PHPMailer/vendor/bin/phpunit \
  --configuration PHPMailer/phpunit.xml.dist \
  --bootstrap phpunit-bootstrap.php \
  "$@"


