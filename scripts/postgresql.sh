#!/bin/sh

set -e
set -x

if [ -z "$DATABASE_URL" ]; then
	printf 'Error: DATABASE_URL is not set\n' >&2
	exit 1
fi

if ! command -v psql >/dev/null; then
	printf 'Error: psql not found\n' >&2
	exit 1
fi

if ! command -v sqlx >/dev/null; then
	printf 'Error: sqlx not found\n' >&2
	exit 1
fi

if [ "$1" = stop ]; then
	podman container stop newsletter-postgresql

	exit
fi

if [ -z "$SKIP_PODMAN" ]; then
	PGDATA="${PGDATA:-/var/lib/postgresql/data}"

	podman volume exists newsletter-pgdata || podman volume create newsletter-pgdata
	podman container exists newsletter-postgresql || podman container create \
		--name newsletter-postgresql \
		-e PGDATA="$PGDATA" \
		-e POSTGRES_HOST_AUTH_METHOD=trust \
		-p 127.0.0.1:5432:5432 \
		-v newsletter-pgdata:"$PGDATA" \
		-v /etc/localtime:/etc/localtime \
		docker.io/postgres:14
	podman container start newsletter-postgresql
fi

until psql "$DATABASE_URL" -c '\q' 2>/dev/null; do
	sleep 0.5
done

sqlx database create
sqlx migrate run
