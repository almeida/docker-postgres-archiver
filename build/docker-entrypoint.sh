#!/bin/bash
set -e

if [ "$1" = 'supervisord' ]; then

	: "${BARMAN_HOST:?Need to set BARMAN_HOST}"
	: "${BARMAN_INCOMING_PATH:?Need to set BARMAN_INCOMING_PATH}"
	BARMAN_SSH_PORT=${BARMAN_SSH_PORT:-22}

	# permissions to postgres archive dir
	PGARCHIVE="/archiver/archive"
	mkdir -p "$PGARCHIVE"
	chmod 700 "$PGARCHIVE"
	chown -R postgres "$PGARCHIVE"

	PGARCHIVECONFIG="/archiver/bin/archive.conf"
	if [ -f "$PGARCHIVECONFIG" ]; then
		rm $PGARCHIVECONFIG
	fi
	echo "BARMAN_HOST=${BARMAN_HOST}" >> $PGARCHIVECONFIG
	echo "BARMAN_SSH_PORT=${BARMAN_SSH_PORT}" >> $PGARCHIVECONFIG
	echo "BARMAN_INCOMING_PATH=${BARMAN_INCOMING_PATH}" >> $PGARCHIVECONFIG

	# permissions to postgres ssh
	PGSSH="/var/lib/postgresql/.ssh"
	mkdir -p "$PGSSH"
	chmod 700 "$PGSSH"
	chown -R postgres "$PGSSH"

	if [ -f "$PGSSH/id_rsa" ]; then
		chmod 600 "$PGSSH/id_rsa"
	fi

	if [ -f "$PGSSH/authorized_keys" ]; then
		chmod 600 "$PGSSH/authorized_keys"
	fi

	if [ -f "$PGSSH/id_rsa.pub" ]; then
		chmod 644 "$PGSSH/id_rsa.pub"
	fi

	if [ -f "$PGSSH/know_hosts" ]; then
		chmod 644 "$PGSSH/know_hosts"
	fi
fi

exec "$@"