local function quit()
	vim.cmd("qa!")
end

local function exit_pane(dir)
	return function()
		vim.fn.jobstart("tmux select-pane -" .. dir, { detach = true })
		quit()
	end
end

vim.keymap.set("n", "q", quit)
vim.keymap.set("n", "<Esc>", quit)
vim.keymap.set("n", "<CR>", quit)
vim.keymap.set("n", "<Space>", quit)

vim.keymap.set("n", "<C-h>", exit_pane("L"), { silent = true })
vim.keymap.set("n", "<C-j>", exit_pane("D"), { silent = true })
vim.keymap.set("n", "<C-k>", exit_pane("U"), { silent = true })
vim.keymap.set("n", "<C-l>", exit_pane("R"), { silent = true })

-- Block insert/replace modes
for i = 1, #"aAiIoORcCsSdDxXrpPuUQ" do
	vim.keymap.set("n", ("aAiIoORcCsSdDxXrpPuUQ"):sub(i, i), "<Nop>")
end
