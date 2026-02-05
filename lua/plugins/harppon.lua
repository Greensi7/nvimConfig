return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	keys = {
		{ "<leader>hh", desc = "Open harpoon window" },
		{ "<leader>ha", desc = "Harpoon add file" },
		{ "<leader>j", desc = "Harpoon select 1" },
		{ "<leader>k", desc = "Harpoon select 2" },
		{ "<leader>l", desc = "Harpoon select 3" },
		{ "<leader>;", desc = "Harpoon select 4" },
	},
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({ settings = {
			save_on_toggle = true,
			sync_on_ui_close = true,
		} })

		-- Toggle menu
		vim.keymap.set("n", "<leader>hh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
			--toggle_telescope(harpoon:list())
		end, { desc = "Open harpoon window" })

		-- REQUIRED: Add current file to harpoon
		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Harpoon add file" })

		-- Quick navigation (example for first 4 files)
		local kye_map = { "j", "k", "l", ";" }
		for i = 1, 4 do
			vim.keymap.set("n", "<leader>" .. kye_map[i], function()
				harpoon:list():select(i)
			end, { desc = "Harpoon select " .. i })
		end
	end,
}
