local file = vim.env.COPY_FILE

local clipboard = os.getenv("COPY_MODE_CLIPBOARD")
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Pipe yanked text into clipboard(s)",
	callback = function()
		local text = table.concat(vim.v.event.regcontents, "\n")
		vim.opt.cursorline = false
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
		vim.fn.jobstart({ "tmux", "set-buffer", "--", text }, { detach = true })
		vim.fn.jobstart({ clipboard, "--", text }, { detach = true })
	end,
})

local f = io.open(file, "r")
local raw = f:read("*a"):gsub("\n+$", "")
local number_of_lines = select(2, raw:gsub("\n", ""))
f:close()

local history_size = tonumber(vim.env.HISTORY_SIZE) or 0
local target_line = history_size + (tonumber(vim.env.CURSOR_Y) or 1) + 1
-- limit target_line to total number of lines + 1 for the line of the command itself
target_line = math.min(target_line, number_of_lines + 1)
local target_col = tonumber(vim.env.CURSOR_X) or 0

local buf = vim.api.nvim_create_buf(false, true)
local chan = vim.api.nvim_open_term(buf, {})
vim.api.nvim_chan_send(chan, raw)

local function render()
	vim.api.nvim_win_set_buf(0, buf)
	vim.bo[buf].modifiable = false
	vim.api.nvim_win_set_cursor(0, { target_line, target_col })
	vim.fn.winrestview({ topline = history_size + 1, lnum = target_line, col = target_col })
end
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.api.nvim_buf_attach(buf, false, {
			on_lines = function()
				if vim.api.nvim_buf_line_count(buf) < number_of_lines then
					return
				end
				vim.schedule(render)
				return true
			end,
		})
	end,
})
