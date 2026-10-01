#!/bin/bash
mkdir -p /mnt/df/screen-monitor
while true
do
  import -window root /mnt/df/screen-monitor/$(date +%s%3N).png
  echo -n "."
  sleep 20s
done
