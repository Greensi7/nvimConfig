return {
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- load it eagerly on startup
        priority = 1000, -- high priority so colorscheme loads first
        config = function()
            require("tokyonight").setup({
                style = "storm",
                transparent = false,
            })
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
}
