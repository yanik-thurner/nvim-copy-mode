#!/usr/bin/env bash
# ~/.config/tmux/scripts/nvim-copy-mode.sh
read -r pane_id cursor_x cursor_y history_size pane_width pane_height \
  <<< "$(tmux display -p '#{pane_id} #{cursor_x} #{cursor_y} #{history_size} #{pane_width} #{pane_height}')"

filename="/dev/shm/tmux-cap-$$"
curtain="/dev/shm/tmux-curtain-$$"

cleanup() { rm -f "$filename" "$curtain"; }
trap cleanup EXIT

tmux capture-pane -t "$pane_id" -p -e -N -S - -E - >> "$filename"
tmux capture-pane -t "$pane_id" -p -e | head -n -1 > "$curtain"

tmux display-popup -xP -yP -w "$pane_width" -h "$pane_height" -EE -B "cat $curtain; exec env CURSOR_Y=$cursor_y CURSOR_X=$cursor_x COPY_FILE=$filename HISTORY_SIZE=$history_size nvim --cmd 'set lazyredraw' --clean -u ./init.lua -c 'terminal cat $curtain'"
