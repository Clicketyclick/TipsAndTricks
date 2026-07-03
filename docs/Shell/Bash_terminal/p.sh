#!/usr/bin/env bash
set -u

if [[ ! -t 1 ]]; then
    echo "This script must be run in an interactive terminal." >&2
    sleep 5
    exit 1
fi

. ./terminal.sh

# Count files first so the percentage is real.
while IFS= read -r -d '' _file; do
    ((total++))
done < <(find . -type f -print0)

setup_terminal

trap restore_terminal EXIT INT TERM
trap handle_resize WINCH

draw_progress 0 "$total" "starting"

if (( total == 0 )); then
    draw_progress 0 0 "no files found"
    exit 0
fi

while IFS= read -r -d '' file; do
    ((processed++))

    # This output scrolls only in the reserved scroll area.
    printf '%s\n' "$file"

    draw_progress "$processed" "$total" "listing files"
done < <(find . -type f -print0)

draw_progress "$total" "$total" "done"