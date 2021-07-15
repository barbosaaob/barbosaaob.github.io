title: Backup with rsync
tags: comp
category: blog
date: 2021-07-15 14:06
modified: 2021-07-15 14:06

# rsync for incremental backup

    rsync -acH --exclude=$EXCLUDE --delete --link-dest=$LAST_BACKUP_DIR \
        $SOURCE_DIR/ $NEW_BACKUP_DIR

where
    
    -a: archive mode; equals -rlptgoD (no -H,-A,-X)
    -c: skip based on checksum, not mod-time & size
    -H: preserve hard links
    --exclude: exclude files matching $EXCLUDE
    --delete: delete extraneous files from dest dirs
    --link-dest: hardlink to files in $LAST_BACKUP_DIR when unchanged

Script:

    #!/bin/sh
    BACKUP_DIR="/mnt/backup"
    mkdir -p $BACKUP_DIR
    LAST_BACKUP_DIR="$BACKUP_DIR/latest"
    SOURCE_DIR="/home/adriano"
    NEW_BACKUP_DIR="$BACKUP_DIR/$(date '+%Y%m%d_%H%M%S')"
    rsync -acH --exclude=Downloads --exclude=.cache --delete \
        --link-dest=$LAST_BACKUP_DIR $SOURCE_DIR/ $NEW_BACKUP_DIR
    rm -rf $LAST_BACKUP_DIR
    ln -s $(basename $NEW_BACKUP_DIR) $BACKUP_DIR/latest

# transfering files

    rsync -zacH --rsync-path="sudo rsync" --link-dest=$LAST_BACKUP_DIR \
        user@remote_server:/mnt/backup/ $NEW_BACKUP_DIR

where
    
    -z: compress file data during the transfer
    -a: archive mode; equals -rlptgoD (no -H,-A,-X)
    -c: skip based on checksum, not mod-time & size
    -H: preserve hard links
    --rsync-path: specify the rsync to run on remote machine
    --link-dest: hardlink to files in $LAST_BACKUP_DIR when unchanged

Notice the trick to call rsync using sudo in the remote machine in case you
need it.

source: [https://linuxconfig.org/how-to-create-incremental-backups-using-rsync-on-linux](https://linuxconfig.org/how-to-create-incremental-backups-using-rsync-on-linux)
