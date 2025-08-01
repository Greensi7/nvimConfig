return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
        require("nvim-tree").setup({
            view = {
                side = "right",
                width = 30,
            },
        })
    end,
}
