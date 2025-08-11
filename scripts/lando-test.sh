#!/usr/bin/env bash

set -euo pipefail

MODE="default"
if [ "${1:-}" = "nombstring" ] || 
   [ "${1:-}" = "noopenssl" ] ||
   [ "${1:-}" = "qmail" ] || 
   [ "${1:-}" = "default" ]; then
  MODE=$1
  shift
fi

if [ "${1:-}" = "--" ]; then
  shift
fi

REM_ARGS=("$@")

if [ -f ./testbootstrap.php ]; then
  cp -f ./testbootstrap.php ./PHPMailer/test/testbootstrap.php
fi

# Environment for relay-based tests (e.g. CRAM-MD5)
export RELAY_HOST=postfix
export RELAY_PORT=25
export RELAY_USERNAME="smtpuser@localhost"
export RELAY_PASSWORD="pass"

PHPUNIT_BIN=(./PHPMailer/vendor/bin/phpunit)

if [ ! -f ./PHPMailer/vendor/autoload.php ]; then
  (cd PHPMailer && composer install --no-interaction --prefer-dist)
fi

if [ "${MODE}" = "nombstring" ]; then
  if php -r 'exit(extension_loaded("mbstring")?0:1);'; then
    echo "Error: mbstring is loaded but should not be in nombstring mode" >&2
    exit 1
  fi

  if [ ! -x /usr/sbin/sendmail ]; then
    if [ -x ./PHPMailer/test/fakesendmail.sh ]; then
      sudo mkdir -p /var/qmail/bin || true
      sudo cp ./PHPMailer/test/fakesendmail.sh /usr/sbin/sendmail
      sudo cp ./PHPMailer/test/fakesendmail.sh /var/qmail/bin/sendmail
      sudo chmod +x /usr/sbin/sendmail /var/qmail/bin/sendmail
    fi
  fi

  PHPUNIT_BIN=(php /usr/local/share/phpunit/phpunit-9.5.6.phar)
elif [ "${MODE}" = "noopenssl" ]; then
  if php -r 'exit(extension_loaded("openssl")?0:1);'; then
    echo "Error: openssl is loaded but should not be in noopenssl mode" >&2
    exit 1
  fi
fi

PHPUNIT_ARGS=(
  --configuration PHPMailer/phpunit.xml.dist
  --bootstrap phpunit-bootstrap.php
)

"${PHPUNIT_BIN[@]}" "${PHPUNIT_ARGS[@]}" "${REM_ARGS[@]}"

