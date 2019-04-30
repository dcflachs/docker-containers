#!/usr/bin/with-contenv sh

#
# Take ownership of files and directories under /mc.
#

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

log() {
    echo "[cont-init.d] $(basename $0): $*"
}

if ! chown -R $USER_ID:$GROUP_ID /mc; then
    # Failed to take ownership of /mc.  This could happen when,
    # for example, the folder is mapped to a network share.
    # Continue if we have write permission, else fail.
    if s6-setuidgid $USER_ID:$GROUP_ID [ ! -w /mc ]; then
        log "ERROR: Failed to take ownership and no write permission on /mc."
        exit 1
    fi
fi


# vim:ft=sh:ts=4:sw=4:et:sts=4