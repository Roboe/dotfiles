#!/usr/bin/env sh

INPUT_FILE="$1"

FILEPATH=$(dirname -z "$INPUT_FILE")
BASENAME=$(basename -z "$INPUT_FILE")
FILENAME="${BASENAME%.*}"
EXTENSION="${BASENAME##*.}"

OUTPUT_FILE=$(zenity --file-selection --save --filename="$FILENAME.trim.$EXTENSION")

DEFAULT_START="0:00:00.000"
DEFAULT_END="$(ffprobe -v error -show_entries format=duration -sexagesimal -of default=noprint_wrappers=1:nokey=1 $INPUT_FILE)"


[ -z "$START" ] && \
  START=$(zenity --entry --title="Trim video" --text="Insert start offset:" --entry-text="$DEFAULT_START")
[ -z "$END" ] && \
  END=$(zenity --entry --title="Trim video" --text="Insert end offset:" --entry-text="$DEFAULT_END")


ffmpeg \
  -ss "$START" \
  -to "$END" \
  -i "$INPUT_FILE" \
  -codec copy \
  "$OUTPUT"

zenity --notification \
  --text="File was successfully trimmed!"
