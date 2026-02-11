local function open_buffer(opts)
	local opts = opts or {}

	local buf_id = vim.api.nvim_create_buf(false, false)
	local width = opts.width or math.floor(vim.o.columns * 0.6)
	local height = opts.height or math.floor(vim.o.lines * 0.6)
	local col = opts.col or ((vim.o.columns - width) * 0.5)
	local row = opts.row or ((vim.o.lines - height) * 0.5)
	local buf_opts = { relative = "editor", width = width, height = height, border = "rounded", row = row, col = col }

	vim.api.nvim_open_win(buf_id, true, buf_opts)
	return buf_id
end

local function open_term()
	local _ = open_buffer()
	vim.cmd.term()
end


