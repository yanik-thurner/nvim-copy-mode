#!/usr/bin/env bash
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

read -r pane_id cursor_x cursor_y history_size pane_width pane_height \
  <<< "$(tmux display -p '#{pane_id} #{cursor_x} #{cursor_y} #{history_size} #{pane_width} #{pane_height}')"

filename="/dev/shm/tmux-cap-$$"
curtain="/dev/shm/tmux-curtain-$$"

cleanup() { rm -f "$filename" "$curtain"; }
trap cleanup EXIT

tmux capture-pane -t "$pane_id" -p -e -S - -E - | sed $'s/$/\033[0m/' >> "$filename"
tmux capture-pane -t "$pane_id" -p -e | head -n -1 > "$curtain"

# captured text doesn't include trailing space in the line of the shell prompt, so we add one manually
if [ "$cursor_x" -lt "$((pane_width - 1))" ]; then
    cursor_line=$((history_size + cursor_y + 1))
    sed -i "${cursor_line}s/$/ /" "$filename"
fi

tmux display-popup -xP -yP -w "$pane_width" -h "$pane_height" -EE -B "cat $curtain; exec env CURSOR_Y=$cursor_y CURSOR_X=$cursor_x COPY_FILE=$filename HISTORY_SIZE=$history_size nvim --cmd 'set lazyredraw' --clean -u \"$CURRENT_DIR\"/init.lua -c 'terminal cat $curtain'"
