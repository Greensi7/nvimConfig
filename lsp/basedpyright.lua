return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
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
}
