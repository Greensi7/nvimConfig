vim.keymap.set("n", "<leader>rm", function()
	local old_path = vim.api.nvim_buf_get_name(0)
	if old_path == "" then
		print("Buffer has no file to delete.")
		return
	end

	local confirm = vim.fn.confirm("Delete file " .. old_path .. "?", "&Yes\n&No", 2)
	if confirm ~= 1 then
		return
	end

	local current = vim.fn.bufnr("%")
	local alternate = vim.fn.bufnr("#")

	if alternate == -1 or alternate == current then
        vim.cmd("enew")
    else
        vim.cmd("b#")
	end
	vim.cmd("!rm " .. old_path)
	vim.cmd(":let @# = bufnr('%')")
end, { desc = "Delete current file and move to empty buffer." })
