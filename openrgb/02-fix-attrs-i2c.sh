#!/bin/bash

for f in /dev/i2c-*
do
	echo "$f"
	chmod 777 $f
done