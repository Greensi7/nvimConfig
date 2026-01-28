return {
	cmd = { "gopls" },
	filetypes = { "gomod", "go" },
	settings = {
		gopls = {
			analyses = { unusedparams = true },
			staticcheck = true,
		},
	},
}
