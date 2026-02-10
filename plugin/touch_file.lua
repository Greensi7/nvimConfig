vim.keymap.set("n", "<leader>tf", function()
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local Path = require("plenary.path")
	local cwd = vim.loop.cwd()
	local folders = {}

	local ignored_dirs = {
		[".git"] = true,
		["__pycache__"] = true,
		["node_modules"] = true,
	}

	table.insert(folders, cwd)

	local function scan_dir(dir)
		local handle = vim.loop.fs_scandir(dir)
		if handle then
			while true do
				local name, type = vim.loop.fs_scandir_next(handle)
				if not name then
					break
				end

				if type == "directory" and not ignored_dirs[name] then
					local full_path = Path:new(dir, name):absolute()
					table.insert(folders, full_path)
					scan_dir(full_path)
				end
			end
		end
	end

	scan_dir(cwd)

	pickers
		.new({}, {
			prompt_title = "Select Folder",
			finder = finders.new_table(folders),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local folder = action_state.get_selected_entry()[1]

					vim.ui.input({ prompt = "New file name: " }, function(input)
						if input and input ~= "" then
							local file = folder .. "/" .. input
							vim.cmd("edit " .. vim.fn.fnameescape(file))
						end
					end)
				end)
				return true
			end,
		})
		:find()
end, { desc = "Create new file in selected folder" })
