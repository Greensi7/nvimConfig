return {

	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = {
					["<Enter>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<Down>"] = cmp.mapping.select_next_item(),
					["<Up>"] = cmp.mapping.select_prev_item(),
					["<C-e>"] = cmp.mapping.abort(),
				},
				sources = {
					{ name = "nvim_lsp" },
				},
			})
		end,
	},
}
