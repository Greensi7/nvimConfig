return {
  {
    "neovim/nvim-lspconfig",
    ft = { "lua", "go", "gomod", "gowork", "gotmpl", "c", "cpp", "objc", "objcpp" },
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
          -- your lua config here (empty means default)
        },
        gopls = {
          cmd = { "gopls" },
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        },
        clangd = {
          -- your clangd config here (empty means default)
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      for server, server_opts in pairs(opts.servers or {}) do
        lspconfig[server].setup(server_opts)
      end
    end,
  },
}
