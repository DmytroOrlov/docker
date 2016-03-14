#!/bin/bash
# wait-for-postgres.sh

set -e

host="$1"
shift

until psql -h "$host" -U "postgres" -c '\l'; do
  sleep 1
done

>&2 echo "$@"
exec "$@"
