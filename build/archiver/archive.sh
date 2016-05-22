#!/bin/bash
set -e
source /archiver/bin/archive.conf
rsync --remove-source-files --exclude='*.tmp' -az -e "ssh -p $BARMAN_SSH_PORT" /archiver/archive/* barman@$BARMAN_HOST:$BARMAN_INCOMING_PATH/
