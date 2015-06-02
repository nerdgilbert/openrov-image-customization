#!/bin/bash
set -xe

for file in /opt/openrov/image-customization/customizations/*; do
  echo "Executing: $file"
  bash -xe $file
done

if [ "$(stat -c %d:%i /)" != "$(stat -c %d:%i /proc/1/root/.)" ]; then
  echo "We are chrooted!"
else
  #flush all buffers to disk
  sync
  blockdev --flushbufs /dev/root
fi
