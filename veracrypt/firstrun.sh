#!/bin/bash

  mkdir -p /nobody/.config/VeraCrypt/

  chown -R nobody:users /nobody/.config/VeraCrypt/
  chmod -R g+rw /nobody/.config/VeraCrypt/

  [ -f /nobody/.config/VeraCrypt/Configuration.xml ] || cp /Configuration.xml /nobody/.config/VeraCrypt/Configuration.xml
  chown -R nobody:users /nobody/.config/VeraCrypt/Configuration.xml
  
  chown -R nobody:users /mnt/disks
