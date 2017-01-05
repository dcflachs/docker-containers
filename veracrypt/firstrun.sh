#!/bin/bash

  mkdir -p /nobody/.config/VeraCrypt/

  chown -R nobody:users /nobody/.config/VeraCrypt/
  chmod -R g+rw /nobody/.config/VeraCrypt/

  chown -R nobody:users /mnt/disks
