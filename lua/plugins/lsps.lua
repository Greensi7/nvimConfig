return {
	{
		"neovim/nvim-lspconfig",
		ft = { "lua", "go", "gomod", "c", "cpp", "python" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
				gopls = {
					cmd = { "gopls" },
					settings = {
						gopls = {
							analyses = { unusedparams = true },
							staticcheck = true,
						},
					},
				},
				clangd = {
					cmd = { "clangd", "--query-driver=/opt/homebrew/bin/arm-none-eabi-*" },
				},
				basedpyright = {
					cmd = { "basedpyright-langserver", "--stdio" },
					settings = {
						python = {
							pythonPath = "/Library/Frameworks/Python.framework/Versions/3.12/bin/python3",
						},
						basedpyright = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "openFilesOnly",
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			for server, server_opts in pairs(opts.servers or {}) do
				vim.lsp.enable(server)
				if server then
					vim.lsp.config(server, server_opts)
				end
			end
		end,
	},
}
