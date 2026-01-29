return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"python",
				"go",
				"c",
				"java",
				"bash",
				"powershell",
				"html",
				"css",
				"javascript",
				"regex",
			},
			auto_install = true,
			highlight = { enable = true },
		})
	end,
}
