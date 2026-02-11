return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			direction = "float",
			shade_terminals = false,
			start_in_insert = true,
			persist_mode = true,
			float_opts = {
				width = function()
					return math.floor(vim.o.columns * 0.9)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.9)
				end,
				border = "rounded",
			},
			close_on_exit = false,
		})
		vim.keymap.set(
			"t",
			"<Esc><Esc>",
			[[<C-\><C-n><cmd>lua _TOGGLE_MYTERM()<CR>]],
			{ noremap = true, silent = true }
		)
		vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

		local Terminal = require("toggleterm.terminal").Terminal
		local myterm = Terminal:new({ direction = "float", hidden = true })

		function _TOGGLE_MYTERM()
			myterm:toggle()
		end

		vim.keymap.set("n", "<leader>a", _TOGGLE_MYTERM, { noremap = true, silent = true })
		vim.keymap.set("n", "<Esc><Esc>", _TOGGLE_MYTERM, { noremap = true, silent = true })
	end,
}
