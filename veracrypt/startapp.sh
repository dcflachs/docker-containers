#!/bin/sh
exec env HOME=/config s6-setuidgid $USER_ID:$GROUP_ID /usr/bin/veracrypt
