Nvim  Copy-Mode
===
Replaces the built in tmux copy-mode with a neovim terminal. It allows you to utizile all vim movements instead of tmux limited ones.


# Installation
You can install it manually by cloning this repo and adding the following snippet to your tmux conf:
```sh
source-file /path/to/repo/nvim-copy-mode.tmux
```

Alternatively, install it via [TPM](https://github.com/tmux-plugins/tpm):
```sh
set -g @plugin 'yanik-thurner/nvim-copy-mode'
```

# Usage
If not explicitly set, the plugin will overwrite the currently bound key. You can set it yourself too with:
```sh
set -g @nvim_copy_mode_activate "<KEY(S)>"
set -g @nvim_copy_mode_activate_prefixless "<KEY(S)>"
```

The following other configuration options currently exist:
```sh
set -g @nvim_copy_mode_cursorline_bg "<TERMINAL COLOR 0 to 15+>" # Background color of the cursor line when in copy mode
set -g @nvim_copy_mode_cursorline_fg "<TERMINAL COLOR 0 to 15+>" # Foreground color of the cursor line when in copy mode
set -g @nvim_copy_mode_clipboard "<CLIPBOARD COMMAND>"           # Clipboard command where the yanked text is piped into
set -g @nvim_copy_mode_closing_delay "<DELAY IN MS>"           # Closing delay after yank where the texts stays highlighted
```
