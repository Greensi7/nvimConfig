vim.keymap.set("n", "<leader>rn", function()
	local buf = vim.api.nvim_get_current_buf()
	local old_path = vim.api.nvim_buf_get_name(buf)

	if old_path == "" then
		vim.notify("Buffer has no file path.", vim.log.levels.WARN)
		return
	end

	local dir = vim.fn.fnamemodify(old_path, ":h")
	local filename = vim.fn.fnamemodify(old_path, ":t")

	vim.ui.input({
		prompt = "New file name: ",
		default = "",
	}, function(input)
		if not input or input == "" or input == filename then
			return
		end

		local new_path = dir .. "/" .. input
		if vim.fn.filereadable(new_path) == 1 then
			vim.notify("File already exists: " .. new_path, vim.log.levels.ERROR)
			return
		end
		vim.cmd("silent! w")
		local success, err = os.rename(old_path, new_path)
		if not success then
			vim.notify("Rename failed: " .. err, vim.log.levels.ERROR)
			return
		end

		vim.api.nvim_buf_set_name(buf, new_path)

		vim.cmd("edit!")

        vim.cmd(":let @# = bufnr('%')")
		vim.notify("Renamed to: " .. input, vim.log.levels.INFO)
	end)
end, { desc = "Rename current file and keep buffer state" })
