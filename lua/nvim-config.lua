-- ~/.config/nvim/copy-mode.lua
vim.opt.termguicolors = false
vim.opt.lazyredraw = true
vim.opt.cursorline = true
vim.cmd("hi CursorLine ctermbg=6 ctermfg=0 cterm=NONE")

-- Hide all chrome
vim.opt.signcolumn = "no"
vim.opt.fillchars = { eob = " " } -- Hide ~ on empty lines
vim.opt.laststatus = 0
vim.opt.cmdheight = 0
vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.shortmess:append("I")

-- Buffer settings
vim.opt.swapfile = false
vim.opt.virtualedit = "onemore"

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
