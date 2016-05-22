# Set postgresql.conf

    wal_level = archive
    archive_mode = on
    archive_command = 'cp %p /archiver/archive/%f.tmp && mv /archiver/archive/%f.tmp /archiver/archive/%f'
