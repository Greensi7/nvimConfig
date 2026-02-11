require("config.lazy")
require("mason").setup()

local lsp_list = {
	"lua_ls",
	"basedpyright",
	"gopls",
	"clangd",
	-- "nil_ls",
	-- "nixd",
	--"ltex",
	--"terraformls",
	--"yamlls",
	--"bashls"
}
require("mason-lspconfig").setup({
	ensure_installed = lsp_list,
	automatic_installation = true,
})
vim.lsp.enable(lsp_list)

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.cursorline = true -- line highlight
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.o.winborder = "rounded"

vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>sl", function()
	vim.lsp.enable(lsp_list, false)
	vim.lsp.enable(lsp_list, true)
	vim.notify("Lsp Servers Restarted", 1)
end)

vim.keymap.set("n", "<leader>ss", function()
	vim.cmd("source $MYVIMRC")
	vim.cmd("echo 'sourced' $MYVIMRC", 1)
end)

vim.keymap.set("n", "<leader>sc", function()
	local buf_id = vim.api.nvim_win_get_buf(0)
	local buf_name = vim.fn.bufname(buf_id)
	vim.cmd("source " .. buf_name)
	vim.notify("sourced " .. buf_name, 1)
end)

vim.keymap.set("x", "p", [["_dP]])
vim.keymap.set("n", "<leader><leader>", "<cmd>b#<CR>", { desc = "Mvoe to the previous buffer" })

local builtin = require("telescope.builtin")
--vim.keymap.set("n", "<leader>fk", builtin, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({ hidden = true })
end, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Telescope man pages" })
vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "Format Buffer" })

vim.api.nvim_set_keymap("n", "<leader>/", ":nohlsearch<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	callback = function()
		vim.cmd("silent! write")
	end,
})

vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end, { noremap = true, silent = true })

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- go to definition
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- find references
vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- go to implementation

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
vim.keymap.set("n", "<leader>E", vim.diagnostic.setloclist, { desc = "Show list of errors" })
