#!/usr/bin/env bash
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

query() {
  tmux show-option -gqv "$1"
}

#### SETTINGS ####

# ACTIVATION
activate_option="@nvim_copy_mode_activate"
activate_value="$(query "$activate_option")"

if [[ -n $activate_value ]]; then
        tmux bind-key -n "$activate_value" run-shell "$CURRENT_DIR/launch.sh"
else
        while IFS= read -r line; do
            table=$(echo "$line" | awk '{print $3}')
            key=$(echo "$line" | awk '{print $4}')

            tmux bind-key -T "$table" "$key" run-shell "$CURRENT_DIR/launch.sh"
        done < <(tmux list-keys | grep -E 'copy-mode(-vi)?$')
fi

# ACTIVATION PREFIXLESS
activate_prefixless_option="@nvim_copy_mode_activate_prefixless"
activate_prefixless_default="C-y"
activate_prefixless_value="$(query "$activate_prefixless_option")"
tmux bind-key -n "${activate_prefixless_value:-$activate_prefixless_default}" run-shell "$CURRENT_DIR/launch.sh"

# CURSORLINE COLORS
cursorline_bg_option="@nvim_copy_mode_cursorline_bg"
cursorline_bg_default="0"
cursorline_bg_value="$(query "$cursorline_bg_option")"
tmux set-environment -g COPY_MODE_CURSORLINE_BG "${cursorline_bg_value:-$cursorline_bg_default}"

cursorline_fg_option="@nvim_copy_mode_cursorline_fg"
cursorline_fg_default="3"
cursorline_fg_value="$(query "$cursorline_fg_option")"
tmux set-environment -g COPY_MODE_CURSORLINE_FG "${cursorline_fg_value:-$cursorline_fg_default}"

# CLIPBOARD PROVIDER
clipboard_option="@nvim_copy_mode_clipboard"
clipboard_default="wl-copy"
clipboard_value="$(query "$clipboard_option")"
tmux set-environment -g COPY_MODE_CLIPBOARD "${clipboard_value:-$clipboard_default}"
