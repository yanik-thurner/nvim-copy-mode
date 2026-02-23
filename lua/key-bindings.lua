local function quit()
	vim.cmd("qa!")
end

local function exit_pane(dir)
	return function()
		vim.fn.jobstart("tmux select-pane -" .. dir, { detach = true })
		quit()
	end
end

-- Quit: q and Ctrl-c cancel in both normal and visual mode (like tmux)
-- Escape cancels in normal mode; in visual mode vim already clears selection (matching tmux clear-selection)
vim.keymap.set({ "n", "x" }, "q", quit)
vim.keymap.set("n", "<Esc>", quit)
vim.keymap.set({ "n", "x" }, "<C-c>", quit)

-- Space begins selection in normal mode (like tmux), Enter cancels in normal mode
vim.keymap.set("n", "<Space>", "v")
vim.keymap.set("n", "<CR>", quit)

-- Enter in visual mode yanks selection (TextYankPost autocmd handles copy + exit)
vim.keymap.set("x", "<CR>", "y")

-- J/K scroll down/up in normal mode (like tmux copy-mode-vi)
vim.keymap.set("n", "J", "<C-e>")
vim.keymap.set("n", "K", "<C-y>")

-- Pane navigation
vim.keymap.set("n", "<C-h>", exit_pane("L"), { silent = true })
vim.keymap.set("n", "<C-j>", exit_pane("D"), { silent = true })
vim.keymap.set("n", "<C-k>", exit_pane("U"), { silent = true })
vim.keymap.set("n", "<C-l>", exit_pane("R"), { silent = true })

-- Block insert/replace/modify modes in normal mode
for i = 1, #"aAiIoORcCsSdDxXrpPuUQ" do
	vim.keymap.set("n", ("aAiIoORcCsSdDxXrpPuUQ"):sub(i, i), "<Nop>")
end

-- Block destructive keys in visual mode (prevent E21 errors on read-only buffer)
-- Note: o/O are intentionally allowed (o = other-end, O = other-corner in block select)
for i = 1, #"aAiIRcCsSdDrpPuU" do
	vim.keymap.set("x", ("aAiIRcCsSdDrpPuU"):sub(i, i), "<Nop>")
end
