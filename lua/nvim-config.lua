-- ~/.config/nvim/copy-mode.lua
vim.opt.termguicolors = false
vim.opt.lazyredraw = true
vim.opt.cursorline = true
local cursorline_bg = os.getenv("COPY_MODE_CURSORLINE_BG")
local cursorline_fg = os.getenv("COPY_MODE_CURSORLINE_FG")
vim.api.nvim_set_hl(0, "CursorLine", {
	ctermfg = tonumber(cursorline_fg),
	ctermbg = tonumber(cursorline_bg),
	cterm = nil,
})

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
