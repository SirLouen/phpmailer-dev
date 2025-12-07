#!/bin/bash
set -euo pipefail

if [ "$#" -eq 0 ]; then
	set -- mysqld
fi

exec /usr/local/bin/docker-entrypoint.sh "$@"
