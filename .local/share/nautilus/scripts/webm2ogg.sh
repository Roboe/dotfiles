#!/usr/bin/env sh

for FILE in "$@"
do
  ffmpeg \
    -i "${FILE}" \
    -codec:a copy \
    -vn \
    -y "${FILE%.webm}.ogg"
done
