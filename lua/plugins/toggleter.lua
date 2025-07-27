return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,
      direction = "float",
      shade_terminals = true,
      start_in_insert = true,
      persist_mode = true,
      close_on_exit = false,
    })

    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

    local Terminal = require("toggleterm.terminal").Terminal
    local myterm = Terminal:new({ direction = "float", hidden = true })

    function _TOGGLE_MYTERM()
      myterm:toggle()
    end

    vim.keymap.set("n", "<leader>a", _TOGGLE_MYTERM, { noremap = true, silent = true })
  end,
}
